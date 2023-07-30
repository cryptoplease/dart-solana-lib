// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart' hide map;
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/encoder.dart';
import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token_list.dart';
import '../../../data/db/db.dart';
import '../../../data/db/mixins.dart';
import '../../transactions/models/tx_sender.dart';
import '../models/off_ramp_payment.dart';

@injectable
class ORPRepository {
  const ORPRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<OffRampPayment?> load(String id) {
    final query = _db.select(_db.oRPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(_tokens));
  }

  Stream<OffRampPayment> watch(String id) {
    final query = _db.select(_db.oRPRows)..where((p) => p.id.equals(id));

    return query.watchSingle().map((row) => row.toModel(_tokens));
  }

  Future<void> save(OffRampPayment payment) async {
    await payment.status.maybeMap(
      txFailure: (status) async {
        await Sentry.captureMessage(
          'ORP tx failure',
          level: SentryLevel.warning,
          withScope: (scope) => scope.setContexts('data', {
            'reason': status.reason,
          }),
        );
      },
      orElse: () async {},
    );

    await _db.into(_db.oRPRows).insertOnConflictUpdate(payment.toDto());
  }

  Future<void> clear() => _db.delete(_db.oRPRows).go();

  Stream<IList<OffRampPayment>> watchReady() =>
      _watchWithStatuses([ORPStatusDto.success]);

  Stream<IList<OffRampPayment>> watchTxCreated() => _watchWithStatuses([
        ORPStatusDto.txCreated,
      ]);

  Stream<IList<OffRampPayment>> watchTxSent() => _watchWithStatuses([
        ORPStatusDto.txSent,
      ]);

  Stream<IList<OffRampPayment>> _watchWithStatuses(
    Iterable<ORPStatusDto> statuses,
  ) {
    final query = _db.select(_db.oRPRows)
      ..where((p) => p.status.isInValues(statuses));

    return query
        .watch()
        .map((rows) => rows.map((row) => row.toModel(_tokens)))
        .map((event) => event.toIList());
  }
}

class ORPRows extends Table with AmountMixin, EntityMixin {
  TextColumn get provider => text()();
  IntColumn get status => intEnum<ORPStatusDto>()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
  IntColumn get txFailureReason => intEnum<TxFailureReason>().nullable()();
  TextColumn get slot => text().nullable()();
}

enum ORPStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
  withdrawn,
}

extension ORPRowExt on ORPRow {
  OffRampPayment toModel(TokenList tokens) => OffRampPayment.signTransaction(
        id: id,
        provider: provider,
        created: created,
        status: status.toModel(this),
        amount: CryptoAmount(
          value: amount,
          cryptoCurrency: CryptoCurrency(token: tokens.findTokenByMint(token)!),
        ),
      );
}

extension on ORPStatusDto {
  ORPStatus toModel(ORPRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final slot = row.slot?.let(BigInt.tryParse);
    final resolvedAt = row.resolvedAt;

    return switch (this) {
      ORPStatusDto.txCreated => ORPStatus.txCreated(
          tx!,
          slot: slot ?? BigInt.zero,
        ),
      ORPStatusDto.txSent => ORPStatus.txSent(
          tx ?? StubSignedTx(row.txId!),
          slot: slot ?? BigInt.zero,
        ),
      ORPStatusDto.success => ORPStatus.success(txId: row.txId!),
      ORPStatusDto.txFailure => ORPStatus.txFailure(
          tx!,
          reason: row.txFailureReason,
        ),
      ORPStatusDto.withdrawn => ORPStatus.withdrawn(
          txId: row.txId ?? '',
          timestamp: resolvedAt,
        ),
    };
  }
}

extension on OffRampPayment {
  ORPRow toDto() => ORPRow(
        id: id,
        provider: provider,
        created: created,
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        txFailureReason: status.toTxFailureReason(),
        slot: status.toSlot()?.toString(),
        resolvedAt: status.toResolvedAt(),
        amount: amount.value,
        token: amount.cryptoCurrency.token.address,
      );
}

extension on ORPStatus {
  ORPStatusDto toDto() => map(
        txCreated: always(ORPStatusDto.txCreated),
        txSent: always(ORPStatusDto.txSent),
        success: always(ORPStatusDto.success),
        txFailure: always(ORPStatusDto.txFailure),
        withdrawn: always(ORPStatusDto.withdrawn),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSent: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        success: (it) => it.txId,
      );

  TxFailureReason? toTxFailureReason() => mapOrNull<TxFailureReason?>(
        txFailure: (it) => it.reason,
      );

  BigInt? toSlot() => mapOrNull(
        txCreated: (it) => it.slot,
        txSent: (it) => it.slot,
      );

  DateTime? toResolvedAt() => mapOrNull(
        withdrawn: (it) => it.timestamp,
      );
}
