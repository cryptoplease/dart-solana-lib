// import 'package:cryptoplease/features/token_details/bl/repository.dart';
// import 'package:cryptoplease/features/token_details/data/coingecko_client.dart';
// import 'package:flutter/material.dart';
// import 'package:nested/nested.dart';
// import 'package:provider/provider.dart';

// class TokenDetailsModule extends SingleChildStatelessWidget {
//   const TokenDetailsModule({Key? key, Widget? child})
//       : super(key: key, child: child);

//   @override
//   Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
//         providers: [
//           Provider<CoingeckoTokenDetailsRepository>(
//             create: (_) => CoingeckoTokenDetailsRepository(
//               coingeckoClient: TokenCoingeckoClient(),
//             ),
//           ),
//         ],
//         child: child,
//       );
// }
