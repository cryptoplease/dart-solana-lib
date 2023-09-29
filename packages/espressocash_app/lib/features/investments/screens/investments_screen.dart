import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/currency.dart';
import '../../../core/presentation/page_fade_wrapper.dart';
import '../../../gen/assets.gen.dart';
import '../../../routes.gr.dart';
import '../../../ui/colors.dart';
import '../../../ui/icon_button.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/theme.dart';
import '../../balances/widgets/refresh_balance_wrapper.dart';
import '../../favorite_tokens/widgets/extensions.dart';
import '../../favorite_tokens/widgets/favorite_tokens_list.dart';
import '../../onboarding/onboarding.dart';
import '../../popular_tokens/widgets/extensions.dart';
import '../../popular_tokens/widgets/popular_token_list.dart';
import '../../profile/screens/profile_screen.dart';
import '../../qr_scanner/widgets/build_context_ext.dart';
import '../../token_search/screens/token_search_screen.dart';
import '../widgets/crypto_investments.dart';
import '../widgets/investment_header.dart';
import '../widgets/popular_crypto_header.dart';
import '../widgets/start_investing_header.dart';

@RoutePage()
class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({super.key});

  static const route = InvestmentsRoute.new;

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  Future<void> _onQrScanner() async =>
      context.launchQrScannerFlow(cryptoCurrency: Currency.usdc);

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: PageFadeWrapper(
          child: Container(
            padding: const EdgeInsets.only(bottom: cpNavigationBarheight),
            child: RefreshBalancesWrapper(
              builder: (context, onRefresh) => RefreshIndicator(
                displacement: 80,
                onRefresh: () => Future.wait([
                  onRefresh(),
                  context.refreshPopularTokens(),
                  context.refreshFavorites(),
                ]),
                color: CpColors.primaryColor,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leading: Center(
                        child: CpIconButton(
                          icon: Assets.icons.qrScanner.svg(),
                          variant: CpIconButtonVariant.black,
                          onPressed: _onQrScanner,
                        ),
                      ),
                      shape: const Border(),
                      title: Center(
                        child: Assets.images.logo.image(height: 32),
                      ),
                      pinned: true,
                      snap: false,
                      floating: false,
                      elevation: 0,
                      backgroundColor: CpColors.darkBackground,
                      actions: [
                        CpIconButton(
                          icon: Assets.icons.searchButtonIcon
                              .svg(color: Colors.white),
                          variant: CpIconButtonVariant.black,
                          onPressed: () =>
                              context.router.push(TokenSearchScreen.route()),
                        ),
                        const SizedBox(width: 12),
                        CpIconButton(
                          icon: Assets.icons.settingsButtonIcon
                              .svg(color: Colors.white),
                          variant: CpIconButtonVariant.black,
                          onPressed: () =>
                              context.router.push(ProfileScreen.route()),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    const SliverToBoxAdapter(child: InvestmentHeader()),
                    const SliverToBoxAdapter(child: OnboardingNotice()),
                    const SliverToBoxAdapter(child: SizedBox(height: 45)),
                    const SliverToBoxAdapter(child: StartInvestingHeader()),
                    const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      sliver: CryptoInvestments(),
                    ),
                    const FavoriteTokenList(),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    const SliverToBoxAdapter(child: PopularCryptoHeader()),
                    const PopularTokenList(),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: max(
                          0,
                          MediaQuery.of(context).padding.bottom -
                              cpNavigationBarheight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
