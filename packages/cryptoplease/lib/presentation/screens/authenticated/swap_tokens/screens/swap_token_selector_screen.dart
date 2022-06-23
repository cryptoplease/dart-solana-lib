import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/selectable_balance_item.dart';
import 'package:cryptoplease/presentation/watch_balance.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class SwapTokenSelectorScreen extends StatefulWidget {
  const SwapTokenSelectorScreen({
    Key? key,
    required this.availableTokens,
    required this.shouldShowBalance,
  }) : super(key: key);

  final Iterable<Token> availableTokens;
  final bool shouldShowBalance;

  @override
  State<SwapTokenSelectorScreen> createState() => _SelectorState();
}

class _SelectorState extends State<SwapTokenSelectorScreen> {
  late Iterable<Token> _tokenList;

  @override
  void initState() {
    super.initState();
    _tokenList = widget.availableTokens;
  }

  void _onSearch(String text) {
    if (text.isEmpty) {
      setState(() => _tokenList = widget.availableTokens);

      return;
    }

    final query = text.toLowerCase();
    final filtered = widget.availableTokens.where(
      (token) =>
          token.name.toLowerCase().contains(query) ||
          token.symbol.toLowerCase().contains(query),
    );
    setState(() => _tokenList = filtered);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: CpColors.darkBackground,
        appBar: CpAppBar(
          title: Text(context.l10n.selectToken),
          leading: const CloseButton(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CpSearchTextField(
                    label: context.l10n.search,
                    onSearch: _onSearch,
                    variant: CpSearchTextVariant.dark,
                  ),
                ),
              ),
            ],
            body: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _tokenList.length,
              itemBuilder: (context, index) {
                final token = _tokenList.elementAt(index);

                return SelectableBalanceItem(
                  token: token,
                  onSelect: (token) => Navigator.of(context).pop(token),
                  balance: widget.shouldShowBalance
                      ? context.watchUserCryptoBalance(token)
                      : null,
                );
              },
            ),
          ),
        ),
      );
}
