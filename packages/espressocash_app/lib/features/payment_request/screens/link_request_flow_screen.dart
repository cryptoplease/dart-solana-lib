import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/amount.dart';
import '../../../core/flow.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../../conversion_rates/data/repository.dart';
import '../data/repository.dart';
import '../services/create_payment_request_bloc.dart';
import '../widgets/request_note_screen.dart';
import 'link_details_flow_screen.dart';

@RoutePage()
class LinkRequestFlowScreen extends StatefulWidget {
  const LinkRequestFlowScreen({
    super.key,
    required this.initialAmount,
  });

  static const route = LinkRequestFlowRoute.new;

  final CryptoAmount initialAmount;

  @override
  State<LinkRequestFlowScreen> createState() => _LinkRequestFlowScreenState();
}

class _LinkRequestFlowScreenState extends State<LinkRequestFlowScreen> {
  late final CreatePaymentRequestBloc _paymentRequestBloc;

  @override
  void initState() {
    super.initState();
    final amount = widget.initialAmount;

    _paymentRequestBloc = CreatePaymentRequestBloc(
      repository: sl<PaymentRequestRepository>(),
      conversionRatesRepository: sl<ConversionRatesRepository>(),
    );

    _paymentRequestBloc.add(
      CreatePaymentRequestEvent.tokenAmountUpdated(amount.decimal),
    );
  }

  @override
  void dispose() {
    _paymentRequestBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Provider<CreatePaymentRequestBloc>.value(
        value: _paymentRequestBloc,
        child: _Content(amount: widget.initialAmount),
      );
}

class _Content extends StatefulWidget {
  const _Content({required this.amount});

  final Amount amount;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> implements NoteSetter {
  @override
  void onNoteSubmitted(String name) {
    final state = context.read<CreatePaymentRequestBloc>().state;

    if (state.tokenAmount.value != 0) {
      final event = CreatePaymentRequestEvent.submitted(
        recipient: context.read<MyAccount>().wallet.publicKey,
      );
      context.read<CreatePaymentRequestBloc>().add(event);
    }
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<NoteSetter>.value(value: this),
        ],
        child:
            BlocConsumer<CreatePaymentRequestBloc, CreatePaymentRequestState>(
          listenWhen: (s1, s2) => s1.flow != s2.flow,
          listener: (context, state) => switch (state.flow) {
            FlowFailure(:final error) =>
              showErrorDialog(context, 'Failed to send money', error),
            FlowSuccess(:final result) => context
              ..router.popUntilRoot()
              ..navigateTo(LinkDetailsFlowScreen.route(id: result.id)),
            _ => null,
          },
          builder: (context, state) => CpLoader(
            isLoading: state.flow.isProcessing,
            child: RequestNoteScreen(amount: widget.amount),
          ),
          buildWhen: (s1, s2) => s1.flow != s2.flow,
        ),
      );
}
