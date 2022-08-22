import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/conversion_rates/presentation/conversion_rates.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/confirm_screen/components/list_item.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:flutter/material.dart';

// TODO(rhbrunetto): used on send-to-address view and will be removed soon
class AmountView extends StatelessWidget {
  const AmountView._({
    Key? key,
    required this.label,
    required this.amount,
    required this.labelStyle,
    required this.amountStyle,
  }) : super(key: key);

  factory AmountView.value({
    required String label,
    required Amount amount,
  }) =>
      AmountView._(
        label: label,
        amount: amount,
        labelStyle: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w600,
        ),
        amountStyle: const TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w600,
        ),
      );

  factory AmountView.fee({
    required String label,
    required Amount fee,
  }) =>
      AmountView._(
        label: label,
        amount: fee,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 21,
        ),
        amountStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 21,
        ),
      );

  final Amount amount;
  final String label;
  final TextStyle labelStyle;
  final TextStyle amountStyle;

  @override
  Widget build(BuildContext context) {
    final convertedAmount = amount.maybeMap(
      crypto: (crypto) => context.convertToFiat(
        fiatCurrency: Currency.usd,
        token: crypto.token,
        amount: crypto.value,
      ),
      orElse: () => null,
    );

    final locale = DeviceLocale.localeOf(context);
    var formattedConverted = convertedAmount?.format(locale);
    final formattedAmount = amount.format(locale);

    if (convertedAmount != null) {
      const minimumAmount = Amount.fiat(value: 1, currency: Currency.usd);
      if (convertedAmount < minimumAmount) {
        final formattedMinimum = minimumAmount.format(locale);
        formattedConverted = '\n< $formattedMinimum';
      } else {
        formattedConverted = '\n≈ $formattedConverted';
      }
    }

    return ListItem(
      label: label,
      labelStyle: labelStyle,
      child: Text.rich(
        TextSpan(
          text: formattedAmount,
          children: [
            if (formattedConverted != null)
              TextSpan(
                text: formattedConverted,
                style: const TextStyle(fontSize: 15),
              ),
          ],
        ),
        style: amountStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
