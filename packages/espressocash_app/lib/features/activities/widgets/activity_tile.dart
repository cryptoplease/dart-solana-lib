import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';

enum CpActivityTileStatus { inProgress, success, failure, canceled }

class CpActivityTile extends StatelessWidget {
  const CpActivityTile({
    super.key,
    required this.title,
    required this.icon,
    required this.status,
    required this.timestamp,
    this.incomingAmount,
    this.outgoingAmount,
    this.onTap,
  });

  final String title;
  final Widget icon;
  final String timestamp;
  final CpActivityTileStatus status;
  final String? incomingAmount;
  final String? outgoingAmount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final incomingAmount = this.incomingAmount;
    final outgoingAmount = this.outgoingAmount;

    final iconSize = Provider.of<double?>(context, listen: false) ?? 42.0;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      leading: SizedBox.square(
        dimension: iconSize,
        child: icon,
      ), //TODO add flag to hide icon
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: _titleStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (incomingAmount != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text('+$incomingAmount', style: _inAmountStyle),
            ),
          if (outgoingAmount != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text('-$outgoingAmount', style: _titleStyle),
            ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(status.text(context), style: _subtitleStyle),
          Text(timestamp, style: _subtitleStyle),
        ],
      ),
    );
  }
}

const _titleStyle = TextStyle(
  fontSize: 16,
  letterSpacing: .23,
  fontWeight: FontWeight.w600,
);

const _inAmountStyle = TextStyle(
  fontSize: 16,
  letterSpacing: .23,
  color: CpColors.incomingAmountColor,
  fontWeight: FontWeight.w500,
);

const _subtitleStyle = TextStyle(
  fontSize: 14,
  letterSpacing: .19,
);

extension on CpActivityTileStatus {
  String text(BuildContext context) {
    switch (this) {
      case CpActivityTileStatus.inProgress:
        return context.l10n.activities_lblInProgress;
      case CpActivityTileStatus.success:
        return context.l10n.activities_lblSuccess;
      case CpActivityTileStatus.failure:
        return context.l10n.activities_lblFailure;
      case CpActivityTileStatus.canceled:
        return context.l10n.activities_lblCanceled;
    }
  }
}
