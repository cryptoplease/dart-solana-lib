import 'package:dfunc/dfunc.dart';
import 'package:espressocash_common/flutter.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../utils/extensions.dart';
import '../../outgoing_link_payments/screens/olp_screen.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class OLPTile extends StatelessWidget {
  const OLPTile({super.key, required this.activity});

  final OLPActivity activity;

  @override
  Widget build(BuildContext context) => CpActivityTile(
        title: context.l10n.sentViaLink,
        outgoingAmount: activity.data.amount.format(context.locale),
        timestamp: context.formatDate(activity.created),
        icon: Assets.icons.paymentIcon.svg(),
        status: activity.data.status.maybeMap(
          withdrawn: always(CpActivityTileStatus.success),
          canceled: always(CpActivityTileStatus.canceled),
          txFailure: always(CpActivityTileStatus.failure),
          orElse: always(CpActivityTileStatus.inProgress),
        ),
        onTap: () => OLPRoute(activity.id).go(context),
      );
}
