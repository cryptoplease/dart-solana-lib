import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/balances/presentation/refresh_balance_wrapper.dart';
import '../../../../core/presentation/page_fade_wrapper.dart';
import '../../../../features/favorite_tokens/widgets/extensions.dart';
import '../../../../features/favorite_tokens/widgets/favorite_tokens_list.dart';
import '../../../../features/investments/widgets/crypto_investments.dart';
import '../../../../features/onboarding/widgets/onboarding_notice.dart';
import '../../../../features/popular_tokens/widgets/extensions.dart';
import '../../../../features/popular_tokens/widgets/popular_token_list.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/icon_button.dart';
import '../../../../ui/navigation_bar/navigation_bar.dart';
import 'components/investment_header.dart';
import 'components/popular_crypto_header.dart';
import 'components/start_investing_header.dart';

@RoutePage(name: 'InvestmentsRouter')
class InvestmentsRouterScreen extends AutoRouter {
  const InvestmentsRouterScreen({super.key});
}

@RoutePage()
class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  @override
  Widget build(BuildContext context) => PageFadeWrapper(
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
                  const SliverAppBar(
                    shape: Border(),
                    title: _AppBarContent(),
                    pinned: true,
                    snap: false,
                    floating: false,
                    elevation: 0,
                    backgroundColor: Colors.white,
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
      );
}

class _AppBarContent extends StatelessWidget {
  const _AppBarContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: kToolbarHeight,
        child: Stack(
          children: [
            Center(
              child: Assets.images.logoDark.image(height: 32),
            ),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Row(
                children: [
                  CpIconButton(
                    icon: Assets.icons.searchButtonIcon.svg(),
                    onPressed: () => context.router.push(TokenSearchRoute()),
                  ),
                  const SizedBox(width: 12),
                  CpIconButton(
                    icon: Assets.icons.settingsButtonIcon.svg(),
                    onPressed: () => context.router.push(const ProfileRoute()),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
