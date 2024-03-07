import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/utils.dart';
import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../../authenticated/authenticated_navigator_key.dart';
import '../../tokens/token.dart';
import '../../transactions/services/create_transaction_link.dart';
import '../../transactions/widgets/transfer_error.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../../transactions/widgets/transfer_success.dart';
import '../data/swap_repository.dart';
import '../models/swap.dart';
import '../services/swap_service.dart';

class ProcessSwapScreen extends StatefulWidget {
  const ProcessSwapScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ProcessSwapScreen> createState() => _ProcessSwapScreenState();
}

class _ProcessSwapScreenState extends State<ProcessSwapScreen> {
  late final Stream<Swap?> _swap;

  @override
  void initState() {
    super.initState();
    _swap = sl<SwapRepository>().watch(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<Swap?>(
        stream: _swap,
        builder: (context, snapshot) {
          final swap = snapshot.data;

          return swap == null
              ? TransferProgress(onBack: () => context.pop())
              : swap.status.maybeMap(
                  success: (status) => TransferSuccess(
                    onBack: () => context.pop(),
                    onOkPressed: () => context.pop(),
                    statusContent: swap.seed.inputToken == Token.usdc
                        ? context.l10n
                            .swapBuySuccess(swap.seed.outputToken.name)
                        : context.l10n
                            .swapSellSuccess(swap.seed.inputToken.name),
                    onMoreDetailsPressed: () {
                      final link = status.tx.id
                          .let(createTransactionLink)
                          .let(Uri.parse)
                          .toString();
                      context.openLink(link);
                    },
                  ),
                  txFailure: (it) => TransferError(
                    onBack: () => context.pop(),
                    onRetry: () => context.retrySwap(swap),
                    reason: it.reason,
                  ),
                  orElse: () => TransferProgress(
                    onBack: () => context.pop(),
                  ),
                );
        },
      );
}

class ProcessSwapRoute extends GoRouteData {
  const ProcessSwapRoute(this.id);

  final String id;

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      authenticatedNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ProcessSwapScreen(id: id);
}

extension on BuildContext {
  Future<void> retrySwap(Swap swap) => runWithLoader(
        this,
        () => sl<SwapService>().retry(
          swap,
          account: read<MyAccount>().wallet,
        ),
      );
}
