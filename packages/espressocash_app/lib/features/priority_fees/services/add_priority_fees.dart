import 'dart:convert' hide Encoding;
import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../config.dart';

import '../../helius/data/dto.dart';
import '../../helius/data/helius_api_client.dart';

@injectable
class AddPriorityFees {
  const AddPriorityFees(
    this._heliusApiClient,
    this._solanaClient,
  );

  final HeliusApiClient _heliusApiClient;
  final SolanaClient _solanaClient;

  Future<SignedTx> call({
    required SignedTx tx,
    required Commitment commitment,
    required int maxTxCostUsdc,
    required Ed25519HDPublicKey platform,
  }) async {
    final maxPriorityFee = maxTxCostUsdc / lamportPriceInUsdcFraction;

    final priorityFees = await _heliusApiClient.getPriorityFeeEstimate(
      GetPriorityFeeEstimateRequest(
        transaction: tx.encode(),
        options: const GetPriorityFeeEstimateOptions(
          includeAllPriorityFeeLevels: true,
          transactionEncoding: TransactionEncoding.base64,
        ),
      ),
    );

    final veryHighFee = priorityFees?.priorityFeeLevels?.veryHigh?.ceil();

    return await _addPriorityFee(
          tx,
          recommendedCuPrice: veryHighFee ?? (pow(2, 32).toInt()),
          maxTxFee: maxPriorityFee.floor(),
          platform: platform,
          commitment: commitment,
        ) ??
        tx;
  }

  Future<SignedTx?> _addPriorityFee(
    SignedTx tx, {
    required int recommendedCuPrice,
    required int maxTxFee,
    required Ed25519HDPublicKey platform,
    required Commitment commitment,
  }) async {
    if (recommendedCuPrice == 0) return tx;

    final sentryData = <String, dynamic>{
      'tx': tx.encode(),
      'recommendedCuPrice': recommendedCuPrice,
      'maxTxFee': maxTxFee,
    };
    final event = SentryEvent(level: SentryLevel.warning)
      ..contexts['Enrichment'] = sentryData;

    final encodedMessage =
        base64Encode(tx.compiledMessage.toByteArray().toList());
    final feeForMessage = await _solanaClient.rpcClient.getFeeForMessage(
      encodedMessage,
      commitment: Commitment.processed,
    );

    sentryData['feeForMessage'] = feeForMessage;

    if (feeForMessage == null) {
      await Sentry.captureEvent(
        event.copyWith(message: const SentryMessage('No feeForMessage')),
      );

      return null;
    }

    final budgetForPriorityFee = (maxTxFee - feeForMessage) * 1000000;
    sentryData['budgetForPriorityFee'] = budgetForPriorityFee;
    if (budgetForPriorityFee < 0) {
      await Sentry.captureEvent(
        event.copyWith(
          message: const SentryMessage('No budget for priority fee'),
        ),
      );

      return null;
    }

    final simulationResult = await _solanaClient.rpcClient.simulateTransaction(
      tx.encode(),
      sigVerify: false,
      replaceRecentBlockhash: true,
      commitment: commitment,
    );
    final unitsConsumed = simulationResult.value.unitsConsumed;
    sentryData['unitsConsumed'] = unitsConsumed;
    if (unitsConsumed == null || unitsConsumed == 0) {
      await Sentry.captureEvent(
        event.copyWith(message: const SentryMessage('No cuLimit')),
      );

      return null;
    }
    final cuLimit = (unitsConsumed * 1.1).ceil();
    sentryData['cuLimit'] = cuLimit;

    final budgetIx =
        ComputeBudgetInstruction.setComputeUnitLimit(units: cuLimit);

    final maxCuPrice = (budgetForPriorityFee.toDouble() / cuLimit).floor();
    sentryData['maxCuPrice'] = maxCuPrice;

    final cuPrice = min(maxCuPrice, recommendedCuPrice);
    sentryData['cuPrice'] = cuPrice;

    final computePriceIx = ComputeBudgetInstruction.setComputeUnitPrice(
      microLamports: cuPrice,
    );

    final message = tx.decompileMessage();
    final Message newMessage;
    final [firstIx, ...otherIxs] = message.instructions;

    if (firstIx.data == SystemProgram.advanceNonceAccountInstructionIndex) {
      newMessage = Message(
        instructions: [
          firstIx,
          computePriceIx,
          budgetIx,
          ...otherIxs,
        ],
      );
    } else {
      newMessage = Message(
        instructions: [
          computePriceIx,
          budgetIx,
          ...message.instructions,
        ],
      );
    }

    final newCompiledMessage = newMessage.compile(
      recentBlockhash: tx.blockhash,
      feePayer: platform,
    );

    return SignedTx(
      compiledMessage: newCompiledMessage,
      signatures: [
        Signature(
          List.filled(64, 0),
          publicKey: platform,
        ), //TODO verify if correct, check if user also needs to sign
        ...tx.signatures.where((s) => s.publicKey != platform),
      ],
    );
  }
}
