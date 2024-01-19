import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../core/cancelable_job.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_payment.dart';
import 'payment_watcher.dart';

/// Watches for [OutgoingDlnPaymentStatus.txSent] orders and waits for the tx to be
/// confirmed.
@injectable
class TxSentWatcher extends OutgoingDlnPaymentWatcher {
  TxSentWatcher(super._repository, this._sender, this._client);

  final TxSender _sender;
  final CryptopleaseClient _client;

  @override
  CancelableJob<OutgoingDlnPayment> createJob(OutgoingDlnPayment payment) =>
      _OrderTxSentJob(payment, _sender, _client);

  @override
  Stream<IList<OutgoingDlnPayment>> watchOrders(
    OutgoingDlnPaymentRepository repository,
  ) =>
      repository.watchTxSent();
}

class _OrderTxSentJob extends CancelableJob<OutgoingDlnPayment> {
  const _OrderTxSentJob(this.payment, this.sender, this.client);

  final OutgoingDlnPayment payment;
  final TxSender sender;
  final CryptopleaseClient client;

  @override
  Future<OutgoingDlnPayment?> process() async {
    final status = payment.status;
    if (status is! OutgoingDlnPaymentStatusTxSent) {
      return payment;
    }

    final tx = await sender.wait(status.tx, minContextSlot: status.slot);
    final orderId = await client
        .fetchDlnOrderId(OrderIdDlnRequestDto(txId: status.tx.id))
        .letAsync((p) => p.orderId);

    final OutgoingDlnPaymentStatus? newStatus = tx.map(
      success: (_) => OutgoingDlnPaymentStatus.success(
        status.tx,
        orderId: orderId,
      ),
      failure: (tx) => OutgoingDlnPaymentStatus.txFailure(reason: tx.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
