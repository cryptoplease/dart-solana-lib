import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:solana/solana.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import 'accounts/bl/ec_wallet.dart';
import 'extensions.dart';

Future<LocalWallet> createLocalWallet({required String mnemonic}) async {
  final wallet = await compute(_createKeyPair, KeyPairParams(mnemonic, 0, 0));

  return LocalWallet(wallet);
}

Future<SagaWallet> createSagaWallet(
  SeedVault seedVault,
  AuthToken authToken,
) async {
  final account = await seedVault
      .getParsedAccounts(authToken, filter: const AccountFilter())
      .letAsync((it) => it.findFirstAccount());

  await seedVault.updateAccountData(authToken, account);

  return SagaWallet(account, authToken);
}

Future<SagaWallet> restoreSagaWallet(
  AuthToken authToken,
  SeedVault seedVault,
) async {
  final account = await seedVault
      .getParsedAuthorizedSeed(authToken)
      .letAsync((it) => it.accounts.findFirstAccount());

  return SagaWallet(account, authToken);
}

extension on List<Account> {
  Account findFirstAccount() {
    /// This is how we determine the "first" wallet. This may vary between
    /// wallet implementations.
    ///
    /// The three BipLevels specified are, respectively:
    /// - purpose, that is set to 44 reffering the BIP-44 proposal
    /// - coin_type, that is set to 501 once Solana is assigned 501 per SLIP-44
    /// - account, that is set to 0 reffering the first indexed account
    /// - change, that is set to 0 reffering external addresses only
    final uri = Bip32DerivationPath.toUri(
      [
        const BipLevel(index: 44, hardened: true),
        const BipLevel(index: 501, hardened: true),
        const BipLevel(index: 0, hardened: true),
        const BipLevel(index: 0, hardened: true),
      ],
    );

    return firstWhere((it) => it.derivationPath == uri);
  }
}

Future<Ed25519HDKeyPair> _createKeyPair(KeyPairParams params) =>
    Ed25519HDKeyPair.fromMnemonic(
      params.mnemonic,
      change: params.change,
      account: params.account,
    );

@immutable
class KeyPairParams {
  const KeyPairParams(this.mnemonic, this.account, this.change);

  final String mnemonic;
  final int account;
  final int change;
}
