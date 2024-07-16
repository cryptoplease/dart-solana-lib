import 'dart:math';

import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart' as dto;
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../utils/transactions.dart';
import '../priority_fees/services/add_priority_fees.dart';
import '../tokens/token.dart';
import 'client/chains.dart';
import 'data/quote_repository.dart';

part 'create_dln_payment.freezed.dart';

@freezed
class QuoteTransaction with _$QuoteTransaction {
  const factory QuoteTransaction({
    required int senderDeductAmount,
    required int receiverAmount,
    required int fee,
    required SignedTx transaction,
  }) = _QuoteTransaction;
}

@injectable
class CreateDlnPayment {
  const CreateDlnPayment(
    this._quoteRepository,
    this._ecClient,
    this._client,
    this._addPriorityFees,
  );

  final QuoteRepository _quoteRepository;
  final EspressoCashClient _ecClient;
  final SolanaClient _client;
  final AddPriorityFees _addPriorityFees;

  Future<QuoteTransaction> call({
    required int amount,
    required String senderAddress,
    required String receiverAddress,
    required Commitment commitment,
    required String receiverChain,
  }) async {
    final nonceData = await _ecClient.getFreeNonce();
    final platformAccount = Ed25519HDPublicKey.fromBase58(nonceData.authority);

    final senderAccount = Ed25519HDPublicKey.fromBase58(senderAddress);

    final chain = receiverChain.toDlnChain;

    if (chain == null) {
      throw ArgumentError.value(
        receiverChain,
        'receiver_Chain',
        'Invalid chain',
      );
    }

    final feePayer = platformAccount;

    final instructions = <Instruction>[];

    final feesFromTransaction = await _client.calculateDlnTxFee(
      sender: senderAccount,
      commitment: commitment,
    );
    final solTransferIx = SystemInstruction.transfer(
      fundingAccount: feePayer,
      recipientAccount: senderAccount,
      lamports: feesFromTransaction,
    );

    instructions.add(solTransferIx);

    final percentageFeeAmount = (amount * outgoingDlnPaymentFeeFraction).ceil();
    final transferFeeAmount = max(percentageFeeAmount, minimumDlnPaymentFee);

    final feeIx = await _createFeePayment(
      aSender: senderAccount,
      aReceiver: feePayer,
      amount: transferFeeAmount,
    );

    instructions.add(feeIx);

    final quote = await _quoteRepository.getQuoteAndTransaction(
      amount: amount,
      senderAddress: senderAddress,
      receiverAddress: receiverAddress,
      receiverChain: chain,
    );

    if (quote.senderDeductAmount != quote.totalFees + quote.inputAmount) {
      throw ArgumentError.value(
        quote,
        'quote',
        'Invalid quote',
      );
    }

    final dlnTx = SignedTx.fromBytes(hex.decode(quote.tx.replaceAll('0x', '')));

    final addressTableLookups = dlnTx.compiledMessage.map(
      legacy: (_) => <MessageAddressTableLookup>[],
      v0: (v0) => v0.addressTableLookups,
    );

    final lookUpTables = await _client.rpcClient
        .getAddressLookUpTableAccounts(addressTableLookups);

    final dlnMessage = dlnTx.let(
      (tx) => tx.decompileMessage(addressLookupTableAccounts: lookUpTables),
    );

    final instructionsWithNonce = [
      SystemInstruction.advanceNonceAccount(
        nonce: Ed25519HDPublicKey.fromBase58(nonceData.nonceAccount),
        nonceAuthority: platformAccount,
      ),
      ...instructions,
    ];

    final message = dlnMessage
        .let((m) => m.removeDefaultComputeIx())
        .let((m) => m.addIxsToFront(instructionsWithNonce));

    final compiled = message.compileV0(
      recentBlockhash: nonceData.nonce,
      feePayer: feePayer,
      addressLookupTableAccounts: lookUpTables,
    );

    final tx = await SignedTx(
      compiledMessage: compiled,
      signatures: [
        platformAccount.emptySignature(),
        senderAccount.emptySignature(),
      ],
    ).let(
      (tx) => _addPriorityFees(
        tx: tx,
        commitment: commitment,
        maxPriorityFee: _maxTxCostUsdc,
        platform: platformAccount,
      ),
    );

    final totalFees = quote.totalFees.toInt() + transferFeeAmount;

    return QuoteTransaction(
      senderDeductAmount: quote.senderDeductAmount,
      receiverAmount: quote.receiverAmount,
      fee: totalFees,
      transaction: tx,
    );
  }
}

extension on Message {
  Message addIxsToFront(List<Instruction> ix) =>
      Message(instructions: [...ix, ...instructions]);

  Message removeDefaultComputeIx() => Message(
        instructions: instructions
            .where((e) => e.programId != ComputeBudgetProgram.id)
            .toList(),
      );
}

Future<Instruction> _createFeePayment({
  required Ed25519HDPublicKey aReceiver,
  required Ed25519HDPublicKey aSender,
  required int amount,
}) async {
  final mint = Token.usdc.publicKey;

  final ataSender = await findAssociatedTokenAddress(
    owner: aSender,
    mint: mint,
  );

  final ataReceiver = await findAssociatedTokenAddress(
    owner: aReceiver,
    mint: mint,
  );

  return TokenInstruction.transfer(
    amount: amount,
    source: ataSender,
    destination: ataReceiver,
    owner: aSender,
  );
}

extension on SolanaClient {
  Future<int> calculateDlnTxFee({
    required Ed25519HDPublicKey sender,
    required Commitment commitment,
  }) async {
    final results = await Future.wait([
      _fetchDlnProtocolFee(commitment: commitment),
      rpcClient.getMinimumBalanceForRentExemption(211),
      rpcClient
          .getMinimumBalanceForRentExemption(TokenProgram.neededAccountSpace),
    ]);

    final nonceAccountCreationFee = await _hasNonceAccount(
      sender: sender,
      commitment: commitment,
    ).letAsync(
      (p) async => p
          ? 0
          : await rpcClient.getMinimumBalanceForRentExemption(16) + 900000,
    );

    return results.sum + nonceAccountCreationFee;
  }

  Future<bool> _hasNonceAccount({
    required Ed25519HDPublicKey sender,
    required Commitment commitment,
  }) async {
    final pda = await Ed25519HDPublicKey.findProgramAddress(
      seeds: ['NONCE'.codeUnits, sender.bytes],
      programId: _dlnSourceAddress,
    );

    final info = await rpcClient
        .getAccountInfo(
          pda.toBase58(),
          commitment: commitment,
          encoding: dto.Encoding.base64,
        )
        .value;

    return info?.data != null;
  }

  Future<int> _fetchDlnProtocolFee({
    required Commitment commitment,
  }) async {
    final pda = await Ed25519HDPublicKey.findProgramAddress(
      seeds: ['STATE'.codeUnits],
      programId: _dlnSourceAddress,
    );

    final info = await rpcClient
        .getAccountInfo(
          pda.toBase58(),
          commitment: commitment,
          encoding: dto.Encoding.base64,
        )
        .value;

    // ignore: avoid-non-null-assertion, required data
    final data = info!.data! as dto.BinaryAccountData;

    return data.data
        .skip(8)
        .skip(32)
        .toList()
        .let(Uint8List.fromList)
        .buffer
        .asByteData()
        .let(BinaryReader.new)
        .readU64()
        .toInt();
  }
}

final _dlnSourceAddress = Ed25519HDPublicKey.fromBase58(
  'src5qyZHqTqecJV4aY6Cb6zDZLMDzrDKKezs22MPHr4',
);

const _maxTxCostUsdc = 2000000; // 2 USDC
const outgoingDlnPaymentFeeFraction = 0.03; // 3%
const incomingDlnPaymentFeePercentage = 3.0; // 3%
const minimumDlnPaymentFee = 3000000; // 3 USDC
