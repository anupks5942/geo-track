// import 'package:flutter/material.dart';
// import 'package:geo_track/services/providers/permission_provider.dart';
// import 'package:provider/provider.dart';

// class PermissionChecker extends StatelessWidget {
//   const PermissionChecker({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: context.read<PermissionProvider>().loadInitialScreen(),
//         builder: (context, snapshot) {
//           return const Center(
//             child: CircularProgressIndicator(
//               strokeWidth: 2,
//               valueColor: AlwaysStoppedAnimation<Color>(
//                 Color.fromARGB(255, 27, 109, 244),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
