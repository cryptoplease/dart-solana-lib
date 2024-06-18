import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../data/db/db.dart';
import '../../../../../accounts/auth_scope.dart';
import '../../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../../stellar/models/stellar_wallet.dart';
import '../../../../../stellar/service/stellar_client.dart';
import '../../data/dto.dart';
import '../../data/moneygram_client.dart';

@Singleton(scope: authScope)
class MoneygramOffRampPostProcessingWatcher {
  MoneygramOffRampPostProcessingWatcher(
    this._db,
    this._apiClient,
    this._stellarClient,
    this._wallet,
  );

  final MyDatabase _db;
  final MoneygramApiClient _apiClient;
  final StellarClient _stellarClient;
  final StellarWallet _wallet;

  @PostConstruct()
  Future<void> init() async {
    final pending = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) =>
            tbl.status.equalsValue(OffRampOrderStatus.postProcessing) &
            tbl.partner.equalsValue(RampPartner.moneygram),
      );

    final pendingOrders = await pending.get();

    for (final order in pendingOrders) {
      unawaited(_subscribe(order));
    }
  }

  Future<void> _subscribe(OffRampOrderRow order) async {
    final id = order.id;
    final accountId = _wallet.address;

    final orderId = order.partnerOrderId;
    String? token = order.authToken;

    token ??= await _stellarClient.fetchToken(wallet: _wallet.keyPair);

    final transaction = await _apiClient
        .fetchTransaction(
          id: orderId,
          authHeader: token.toAuthHeader(),
        )
        .then((e) => e.transaction);

    if (transaction.status == MgStatus.pendingUserTransferStart) {
      await _stellarClient.sendUsdc(
        accountId,
        order.withdrawAnchorAccount ?? '',
        order.withdrawMemo ?? '',
        transaction.amountIn ?? '',
      );
    }
  }
}
