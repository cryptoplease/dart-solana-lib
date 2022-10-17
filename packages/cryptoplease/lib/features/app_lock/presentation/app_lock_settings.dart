import 'package:cryptoplease/features/app_lock/bl/app_lock_bloc.dart';
import 'package:cryptoplease/features/app_lock/presentation/app_lock_setup_flow_screen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/switch.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLockSettingsScreen extends StatelessWidget {
  const AppLockSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(context.l10n.appLock),
            leading: BackButton(
              onPressed: context.read<AppLockSetupRouter>().closeFlow,
            ),
          ),
          body: BlocBuilder<AppLockBloc, AppLockState>(
            builder: (context, state) => CpSwitch(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              title: context.l10n.enableSecurity,
              value: state is AppLockStateEnabled,
              onChanged: (value) {
                if (value) {
                  context.read<AppLockSetupRouter>().onEnable();
                } else {
                  context.read<AppLockSetupRouter>().onDisable();
                }
              },
            ),
          ),
        ),
      );
}
