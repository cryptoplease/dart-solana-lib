import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/dynamic_links_notifier.dart';
import '../../../core/flow.dart';
import '../../../core/link_payments.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../routes.gr.dart';
import '../../../ui/colors.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/loader.dart';
import '../../accounts/services/accounts_bloc.dart';
import '../services/sign_in_bloc.dart';

@RoutePage()
class SignInFlowScreen extends StatefulWidget {
  const SignInFlowScreen({super.key});

  static const route = SignInFlowRoute.new;

  @override
  State<SignInFlowScreen> createState() => _SignInFlowScreenState();
}

class _SignInFlowScreenState extends State<SignInFlowScreen> {
  late final SignInBloc _signInBloc;

  @override
  void initState() {
    super.initState();
    _signInBloc = sl<SignInBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(Assets.images.dollarBg.provider(), context);

    context.watch<DynamicLinksNotifier>().link?.let(_parseUri).let((valid) {
      if (valid) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _signInBloc.add(const SignInEvent.newLocalWalletRequested()),
        );
      }
    });
  }

  @override
  void dispose() {
    _signInBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider<SignInBloc>.value(value: _signInBloc),
        ],
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) => switch (state.processingState) {
            FlowFailure(:final error) => error.when(
                seedVaultActionCanceled: ignore,
                generic: (e) => showErrorDialog(context, 'Error', e),
              ),
            FlowSuccess(:final result) => context.read<AccountsBloc>().add(
                  AccountsEvent.created(
                    account: result.account,
                    source: state.source,
                  ),
                ),
            _ => null,
          },
          builder: (context, state) => CpLoader(
            isLoading: state.processingState.isProcessing,
            child: AutoRouter(
              placeholder: (context) => const ColoredBox(
                color: CpColors.yellowSplashBackgroundColor,
              ),
            ),
          ),
        ),
      );
}

bool _parseUri(Uri? link) {
  if (link == null) return false;

  return LinkPayments.tryParse(link) != null;
}
