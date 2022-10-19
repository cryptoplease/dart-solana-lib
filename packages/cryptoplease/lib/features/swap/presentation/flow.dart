import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/dialogs.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/swap/bl/create_swap/bloc.dart';
import 'package:cryptoplease/features/swap/bl/repository.dart';
import 'package:cryptoplease/features/swap/bl/swap_exception.dart';
import 'package:cryptoplease/features/swap/swap_screen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

enum SwapOperation { buy, sell }

extension on SwapOperation {
  String label(BuildContext context, Token input, Token output) {
    switch (this) {
      case SwapOperation.buy:
        return context.l10n.buyToken(output.symbol);
      case SwapOperation.sell:
        return context.l10n.sellToken(input.symbol);
    }
  }
}

extension SwapFlowExt on BuildContext {
  void navigateToBuyToken(Token token) => navigateTo(
        SwapFlowRoute(
          // TODO: remove
          inputToken: Token.usdcProd,
          outputToken: token,
          slippage: Decimal.one,
          operation: SwapOperation.buy,
        ),
      );

  void navigateToSellToken(Token token) => navigateTo(
        SwapFlowRoute(
          inputToken: token,
          // TODO: remove
          outputToken: Token.usdcProd,
          slippage: Decimal.one,
          operation: SwapOperation.sell,
        ),
      );
}

class SwapFlowScreen extends StatefulWidget {
  const SwapFlowScreen({
    Key? key,
    required this.inputToken,
    required this.outputToken,
    required this.slippage,
    required this.operation,
  }) : super(key: key);

  final Token inputToken;
  final Token outputToken;
  final Decimal slippage;
  final SwapOperation operation;

  @override
  State<SwapFlowScreen> createState() => _FlowState();
}

class _FlowState extends State<SwapFlowScreen> {
  late final CreateSwapBloc createSwapBloc;

  @override
  void initState() {
    super.initState();
    final jupiterRepo = JupiterRepository(
      jupiterAggregatorClient: JupiterAggregatorClient(),
      solanaClient: sl<SolanaClient>(),
      tokenList: sl<TokenList>(),
    );

    createSwapBloc = CreateSwapBloc(
      input: widget.inputToken,
      output: widget.outputToken,
      initialSlippage: Decimal.one,
      jupiterRepository: jupiterRepo,
      balances: context.read<BalancesBloc>().state.balances,
      swapOperation: widget.operation,
    )..add(
        const CreateSwapEvent.initialized(),
      );
  }

  void _onSubmit() => createSwapBloc.add(const CreateSwapEvent.submitted());

  void _onSlippageUpdate(Decimal value) {
    createSwapBloc.add(CreateSwapEvent.slippageUpdated(value));
  }

  void _onRequestTokenChanged(Token _) {
    const event = CreateSwapEvent.editingModeToggled();
    createSwapBloc.add(event);
  }

  void _onAmountUpdate(
    Amount amount,
    Decimal value,
  ) {
    if (value == amount.decimal) return;

    final event = CreateSwapEvent.amountUpdated(value);
    createSwapBloc.add(event);
  }

  void _onSwapException(SwapException e) => showErrorDialog(
        context,
        'Failed',
        e,
      );

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<CreateSwapBloc, CreateSwapState>(
        bloc: createSwapBloc,
        listenWhen: (previous, current) =>
            previous.flowState != current.flowState,
        listener: (context, state) => state.flowState.whenOrNull(
          failure: _onSwapException,
          success: (r) => context.router.navigate(
            SwapTokenProcessRoute(route: r),
          ),
        ),
        builder: (context, state) => SwapScreen(
          title: widget.operation.label(context, state.input, state.output),
          inputAmount: state.inputAmount,
          outputAmount: state.outputAmount,
          displayAmount: state.requestAmount,
          slippage: state.slippage,
          maxAmountAvailable: createSwapBloc.calculateMaxAmount(),
          loading: state.flowState.isProcessing(),
          onSlippageChanged: _onSlippageUpdate,
          onAmountChanged: (value) => _onAmountUpdate(
            state.inputAmount,
            value,
          ),
          onSubmit: _onSubmit,
          onRequestTokenChanged: _onRequestTokenChanged,
        ),
      );
}
