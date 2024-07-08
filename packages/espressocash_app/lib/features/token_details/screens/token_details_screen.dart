import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../activities/widgets/recent_activity.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/token_fiat_balance_service.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../ramp/widgets/ramp_buttons.dart';
import '../../tokens/token.dart';
import '../widgets/token_app_bar.dart';
import '../widgets/token_info.dart';

class TokenDetailsScreen extends StatefulWidget {
  const TokenDetailsScreen({super.key, required this.token});

  static void push(BuildContext context, {required Token token}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => TokenDetailsScreen(token: token),
        ),
      );

  final Token token;

  @override
  State<TokenDetailsScreen> createState() => _TokenDetailsScreenState();
}

class _TokenDetailsScreenState extends State<TokenDetailsScreen> {
  late ScrollController _scrollController;
  double _paddingTop = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _paddingTop =
          (_scrollController.offset > 56) ? 56 : _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) => Provider<Token>.value(
        value: widget.token,
        child: CpTheme.dark(
          child: Scaffold(
            backgroundColor: CpColors.darkGoldBackgroundColor,
            body: SafeArea(
              bottom: false,
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, _) => [
                  TokenAppBar(token: widget.token),
                ],
                body: Padding(
                  padding: EdgeInsets.only(top: _paddingTop),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(31),
                      topRight: Radius.circular(31),
                    ),
                    child: LayoutBuilder(
                      builder: (
                        BuildContext context,
                        BoxConstraints viewportConstraints,
                      ) =>
                          SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight,
                          ),
                          child: DecoratedBox(
                            decoration: const BoxDecoration(),
                            child: IntrinsicHeight(
                              child: Column(
                                children: [
                                  const SizedBox(height: 4),
                                  const _TokenHeader(),
                                  const SizedBox(height: 33),
                                  if (widget.token.isUsdcToken)
                                    const _RampButtons()
                                  else
                                    const _SwapButton(),
                                  const SizedBox(height: 41),
                                  Expanded(
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                        color:
                                            CpColors.dashboardBackgroundColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(31),
                                          topRight: Radius.circular(31),
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 41,
                                          ),
                                          child: Column(
                                            children: [
                                              TokenInfo(
                                                tokenAddress:
                                                    widget.token.address,
                                              ),
                                              RecentTokenActivityWidget(
                                                tokenAddress:
                                                    widget.token.address,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _TokenHeader extends StatelessWidget {
  const _TokenHeader();

  @override
  Widget build(BuildContext context) {
    final token = context.watch<Token>();

    final rate = sl<ConversionRatesRepository>().readRate(
          CryptoCurrency(token: token),
          to: defaultFiatCurrency,
        ) ??
        Decimal.zero;

    return ValueStreamBuilder<CryptoFiatAmount>(
      create: () => (
        sl<TokenFiatBalanceService>().readInvestmentBalance(token),
        (
          Amount.zero(currency: Currency.usdc) as CryptoAmount,
          Amount.zero(currency: Currency.usd) as FiatAmount
        )
      ),
      builder: (context, value) {
        final crypto = value.$1;
        final fiat = value.$2;

        final fiatRate =
            Amount.fromDecimal(value: rate, currency: Currency.usd);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: 'Balance ',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: fiat?.format(context.locale),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              FittedBox(
                child: Text(
                  crypto.format(
                    context.locale,
                    maxDecimals: 4,
                  ),
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 59,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: 'Price ',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          '\$${fiatRate.formatRate(rate.toDouble(), context.locale)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RampButtons extends StatelessWidget {
  const _RampButtons();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AddCashButton(),
            SizedBox(width: 16),
            CashOutButton(),
          ],
        ),
      );
}

// Won't be available in first release
class _SwapButton extends StatelessWidget {
  const _SwapButton();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CpButton(
              text: 'Swap',
              minWidth: 106,
              size: CpButtonSize.big,
              onPressed: () => showInfoDialog(
                context,
                title: 'Swap',
                message: 'Coming soon!',
                confirmLabel: 'OK',
                onConfirm: () {},
              ),
            ),
            const SizedBox(width: 14),
            CpButton(
              text: 'Send',
              minWidth: 106,
              size: CpButtonSize.big,
              onPressed: () => showInfoDialog(
                context,
                title: 'Send',
                message: 'Coming soon!',
                confirmLabel: 'OK',
                onConfirm: () {},
              ),
            ),
          ],
        ),
      );
}

extension on Token {
  bool get isUsdcToken => address == Token.usdc.address;
}
