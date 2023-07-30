import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cancelable_job.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/off_ramp_payment.dart';
import 'payment_watcher.dart';

/// Watches for [ORPStatus.txCreated] payments and and sends the tx.
///
/// The watcher will try to submit the tx until it's accepted or rejected.
@injectable
class TxCreatedWatcher extends PaymentWatcher {
  TxCreatedWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<OffRampPayment> createJob(
    OffRampPayment payment,
  ) =>
      _ORPTxCreatedJob(payment, _sender);

  @override
  Stream<IList<OffRampPayment>> watchPayments(
    ORPRepository repository,
  ) =>
      repository.watchTxCreated();
}

class _ORPTxCreatedJob extends CancelableJob<OffRampPayment> {
  const _ORPTxCreatedJob(this.payment, this.sender);

  final OffRampPayment payment;
  final TxSender sender;

  @override
  Future<OffRampPayment?> process() async {
    final status = payment.status;
    if (status is! ORPStatusTxCreated) {
      return payment;
    }

    final tx = await sender.send(status.tx, minContextSlot: status.slot);

    final ORPStatus? newStatus = tx.map(
      sent: (_) => ORPStatus.txSent(
        status.tx,
        slot: status.slot,
      ),
      invalidBlockhash: (_) => ORPStatus.txFailure(
        status.tx,
        reason: TxFailureReason.invalidBlockhashSending,
      ),
      failure: (it) => ORPStatus.txFailure(status.tx, reason: it.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }
}
