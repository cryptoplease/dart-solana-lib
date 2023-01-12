import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/encoder/message/message_v0.dart';
import 'package:solana/src/encoder/signed_tx_v0.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final fundingAccount = await Ed25519HDKeyPair.random();
  final recipientAccount = await Ed25519HDKeyPair.random();

  group('legacy', () {
    final message = Message.only(
      SystemInstruction.transfer(
        fundingAccount: fundingAccount.publicKey,
        recipientAccount: recipientAccount.publicKey,
        lamports: 1000,
      ),
    );

    test('Returns correct required signature count', () {
      final compiledMessage = message.compile(
        recentBlockhash: base58encode([0, 0, 0]),
      );

      expect(compiledMessage.requiredSignatureCount, 1);
    });

    test('Returns correct transaction version', () {
      final compiledMessage = message.compile(
        recentBlockhash: base58encode([0, 0, 0]),
      );

      expect(compiledMessage.version, TransactionVersion.legacy);
    });

    test('Creates compiled message from signed tx', () async {
      final compiledMessage = message.compile(
        recentBlockhash: base58encode([0, 0, 0]),
      );
      final signedTx = SignedTx(
        messageBytes: compiledMessage.data,
        signatures: [await fundingAccount.sign(compiledMessage.data)],
      );

      final fromSigned =
          CompiledMessage.fromSignedTransaction(signedTx.toByteArray());

      expect(compiledMessage, fromSigned);
    });
  });

  group('v0', () {
    final message = Messagev0.only(
      SystemInstruction.transfer(
        fundingAccount: fundingAccount.publicKey,
        recipientAccount: recipientAccount.publicKey,
        lamports: 1000,
      ),
    );

    test('Returns correct required signature count', () {
      final compiledMessage = message.compile(
        recentBlockhash: base58encode([0, 0, 0]),
        feePayer: fundingAccount.publicKey,
      );

      expect(compiledMessage.requiredSignatureCount, 1);
    });

    test('Returns correct transaction version', () {
      final compiledMessage = message.compile(
        recentBlockhash: base58encode([0, 0, 0]),
        feePayer: fundingAccount.publicKey,
      );

      expect(compiledMessage.version, TransactionVersion.v0);
    });

    test('Creates compiled message from signed tx', () async {
      final compiledMessage = message.compile(
        recentBlockhash: base58encode([0, 0, 0]),
        feePayer: fundingAccount.publicKey,
      );
      final signedTx = SignedTxV0(
        messageBytes: compiledMessage.data,
        signatures: [await fundingAccount.sign(compiledMessage.data)],
      );

      final fromSigned =
          CompiledMessage.fromSignedTransaction(signedTx.toByteArray());

      expect(compiledMessage, fromSigned);
    });
  });
}
