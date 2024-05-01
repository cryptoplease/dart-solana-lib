import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../utils/extensions.dart';
import '../../payment_request/data/watch_payment_request.dart';
import '../../payment_request/models/payment_request.dart';
import '../../payment_request/screens/request_payment_status_screen.dart';
import '../../payment_request/widgets/formatted_amount.dart';
import 'activity_tile.dart';

class PaymentRequestTile extends StatefulWidget {
  const PaymentRequestTile({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<PaymentRequestTile> createState() => _PaymentRequestTileState();
}

class _PaymentRequestTileState extends State<PaymentRequestTile> {
  late Stream<PaymentRequest> _stream;

  @override
  void initState() {
    super.initState();
    _stream = watchPaymentRequest(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<PaymentRequest>(
        stream: _stream,
        builder: (context, snapshot) {
          final data = snapshot.data;

          return data == null
              ? SizedBox.shrink(key: ValueKey(widget.id))
              : CpActivityTile(
                  key: ValueKey(widget.id),
                  title: context.l10n.paymentRequestTitle,
                  icon: Assets.icons.paymentIcon.svg(),
                  timestamp: context.formatDate(data.created),
                  incomingAmount:
                      data.formattedAmount(DeviceLocale.localeOf(context)),
                  status: switch (data.state) {
                    PaymentRequestState.initial =>
                      CpActivityTileStatus.inProgress,
                    PaymentRequestState.completed =>
                      CpActivityTileStatus.success,
                    PaymentRequestState.error => CpActivityTileStatus.failure,
                  },
                  onTap: () => PaymentRequestStatusRoute(data.id).go(context),
                );
        },
      );
}
