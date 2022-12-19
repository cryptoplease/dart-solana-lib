import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/balances/presentation/refresh_balance_wrapper.dart';
import '../../../../features/investments/module.dart';
import '../../../../features/popular_tokens/module.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/icon_button.dart';
import '../../../../ui/navigation_bar/navigation_bar.dart';
import 'components/popular_crypto_header.dart';
import 'components/total_balance_widget.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  @override
  Widget build(BuildContext context) => RefreshBalancesWrapper(
        builder: (context, onRefresh) => RefreshIndicator(
          displacement: 80,
          onRefresh: () => Future.wait([
            onRefresh(),
            context.read<PopularTokenBloc>().refresh(),
          ]),
          color: CpColors.primaryColor,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                shape: const Border(),
                title: const _AppBarContent(),
                pinned: true,
                snap: false,
                floating: false,
                elevation: 0,
                backgroundColor: Colors.white,
                expandedHeight:
                    MediaQuery.of(context).padding.top + kToolbarHeight + 100,
                collapsedHeight: kToolbarHeight + 40,
                flexibleSpace: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight,
                    bottom: 16,
                  ),
                  child: const TotalBalanceWidget(),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(left: 24, right: 24),
                sliver: MyPortfolio(),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 54, bottom: 24),
                  child: PopularCryptoHeader(),
                ),
              ),
              const PopularTokenList(),
              const SliverToBoxAdapter(
                child: SizedBox(height: cpNavigationBarheight + 56),
              )
            ],
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
              child: Text(context.l10n.investments),
            ),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: CpIconButton(
                icon: Assets.icons.searchButtonIcon.svg(),
                onPressed: () => context.router.push(const TokenSearchRoute()),
              ),
            ),
          ],
        ),
      );
}
