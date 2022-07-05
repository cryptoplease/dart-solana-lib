import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/authenticated/add_funds/presentation/routes.dart';
import 'package:cryptoplease/authenticated/app_lock/presentation/routes.dart';
import 'package:cryptoplease/authenticated/backup_phrase/presentation/routes.dart';
import 'package:cryptoplease/authenticated/profile/edit_profile_screen.dart';
import 'package:cryptoplease/authenticated/profile/help_screen.dart';
import 'package:cryptoplease/authenticated/profile/profile_screen.dart';
import 'package:cryptoplease/core/presentation/legal_document_view.dart';
import 'package:cryptoplease/presentation/screens/authenticated/activities/activities_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/flow.dart';
import 'package:cryptoplease/presentation/screens/authenticated/home_tabs_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/nft/nft_details_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/nft/nft_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/outgoing_transfer_flow/outgoing_transfer_flow.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/swap_token_flow.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/transaction_details_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transactions_screen/transactions_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/wallet_screen.dart';

const authenticatedFlowRoutes = AutoRoute<void>(
  page: AuthenticatedFlowScreen,
  children: [
    AutoRoute<void>(
      path: '',
      page: HomeTabsScreen,
      children: [
        CustomRoute<void>(path: '', page: WalletScreen),
        CustomRoute<void>(page: NftScreen),
        CustomRoute<void>(page: ActivitiesScreen),
        CustomRoute<void>(page: SwapTokenFlowScreen, children: swapTokenRoutes),
        CustomRoute<void>(page: ProfileScreen),
      ],
    ),
    ...backupPhraseRoutes,
    AutoRoute<void>(page: NftDetailsScreen),
    AutoRoute<void>(page: TransactionsScreen),
    AutoRoute<void>(page: TransactionDetailsScreen),
    ...createPaymentFlowRoutes,
    AutoRoute<void>(page: OutgoingTransferFlowScreen),
    ...receiveFlowRoutes,
    ...addFundsRoutes,
    appLockSetupFlowRoutes,
    AutoRoute<void>(page: EditProfileScreen),
    AutoRoute<void>(page: TermsOfServiceScreen),
    AutoRoute<void>(page: PrivacyPolicyScreen),
    AutoRoute<void>(page: HelpScreen),
  ],
);
