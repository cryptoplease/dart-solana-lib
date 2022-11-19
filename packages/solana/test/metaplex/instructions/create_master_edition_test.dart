import 'package:solana/metaplex.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/metaplex/instructions/create_master_edition.dart';
import 'package:test/test.dart';

import '../../config.dart';

Future<void> main() async {
  const uri = 'https://arweave.net/LogULMuEjDSOg-TnsboIF6UvmZyyr6j3BDCN4p46Frc';
  const name = 'Cofre #514';
  const symbol = 'COFR';

  // TODO(KB): Setup localnet with the metaplex program deployed.
  final client = createTestSolanaClient(useLocal: false);
  final owner = await Ed25519HDKeyPair.random();

  test(
    'creates master edition',
    () async {
      await client.requestAirdrop(
        address: owner.publicKey,
        lamports: 1 * lamportsPerSol,
        commitment: Commitment.confirmed,
      );
      final mint = await client.initializeMint(
        mintAuthority: owner,
        decimals: 0,
        commitment: Commitment.confirmed,
      );

      final data = CreateMetadataAccountV3Data(
        name: name,
        symbol: symbol,
        uri: uri,
        sellerFeeBasisPoints: 550,
        isMutable: false,
        colectionDetails: false,
      );
      final instruction = await createMetadataAccountV3(
        mint: mint.address,
        mintAuthority: owner.publicKey,
        payer: owner.publicKey,
        updateAuthority: owner.publicKey,
        data: data,
      );

      final message = Message.only(instruction);

      await client.sendAndConfirmTransaction(
        message: message,
        signers: [owner],
        commitment: Commitment.confirmed,
      );

      final dataMaster = CreateMasterEditionV3Data(maxSupply: 0);
      final instructionMaster = await createMasterEditionV3(
        mint: mint.address,
        updateAuthority: owner.publicKey,
        mintAuthority: owner.publicKey,
        payer: owner.publicKey,
        metadataAccount: mint.address,
        data: dataMaster,
      );

      final messageMaster = Message.only(instructionMaster);

      await client.sendAndConfirmTransaction(
        message: messageMaster,
        signers: [owner],
        commitment: Commitment.confirmed,
      );

      final metadata = await client.rpcClient.getMetadata(
        mint: mint.address,
        commitment: Commitment.confirmed,
      );

      expect(metadata?.name, name);
      expect(metadata?.symbol, symbol);
      expect(metadata?.uri, uri);
    },
  );
}
