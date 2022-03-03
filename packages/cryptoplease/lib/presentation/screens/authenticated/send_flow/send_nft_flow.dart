import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/conversion_rates/repository.dart';
import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_transfers_bloc/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/user_preferences.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/send_flow_router.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SendNftFlowScreen extends StatefulWidget {
  const SendNftFlowScreen({
    Key? key,
    required this.nft,
  }) : super(key: key);

  final SplToken nft;

  @override
  State<SendNftFlowScreen> createState() => _State();
}

class _State extends State<SendNftFlowScreen> implements SendFlowRouter {
  late final CreateOutgoingTransferBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CreateOutgoingTransferBloc(
      repository: context.read<OutgoingTransferRepository>(),
      balances: context.read<BalancesBloc>().state.balances,
      conversionRatesRepository: context.read<ConversionRatesRepository>(),
      userCurrency: context.read<UserPreferences>().fiatCurrency,
    );

    _reset();
  }

  void _reset() {
    _bloc.add(const CreateOutgoingTransferEvent.cleared());
    final initialToken = widget.nft;
    _bloc.add(
      CreateOutgoingTransferEvent.nftTransferCreated(initialToken),
    );
  }

  @override
  void onDirectSelected() {
    _reset();

    context.router.navigate(const EnterAddressRoute());
  }

  @override
  Future<void> onQrCodeSelected() async {
    final request =
        await context.router.push<QrScannerRequest>(const QrScannerRoute());

    _reset();

    request?.maybeMap(
      address: (r) {
        _bloc.add(CreateOutgoingTransferEvent.recipientUpdated(r.address));
        onAddressSubmitted();
      },
      orElse: () {},
    );
  }

  @override
  void onSplitKeySelected() {
    _reset();

    const event =
        CreateOutgoingTransferEvent.typeUpdated(OutgoingTransferType.splitKey);
    _bloc.add(event);

    context.router.navigate(const ConfirmRoute());
  }

  @override
  void onAddressSubmitted() {
    context.router.navigate(const ConfirmRoute());
  }

  @override
  void onAmountSubmitted() {
    context.router.navigate(const ConfirmRoute());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider.value(value: _bloc),
          Provider<SendFlowRouter>.value(value: this),
        ],
        child: BlocListener<CreateOutgoingTransferBloc,
            CreateOutgoingTransferState>(
          listenWhen: (s1, s2) => s1.flow != s2.flow,
          listener: (context, state) => state.flow.maybeMap(
            success: (s) {
              Navigator.of(context).pop();
              context.router.navigate(OutgoingTransferFlowRoute(id: s.result));
              context
                  .read<OutgoingTransfersBloc>()
                  .add(OutgoingTransfersEvent.submitted(s.result));
            },
            orElse: ignore,
          ),
          child: const AutoRouter(),
        ),
      );
}
