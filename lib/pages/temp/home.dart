// import 'package:flutter/material.dart';
// import 'package:geo_track/pages/tabs/manual.dart';
// import 'package:geo_track/pages/tabs/profile.dart';
// import 'package:geo_track/pages/tabs/google_map.dart';
// // import 'package:geo_track/utils/constants.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _tabs = const [
//     GoogleMap(),
//     ManualCheckinPage(),
//     ProfileScreen(),
//   ];

//   // void onTabTapped(int index) {
//   //   setState(() {
//   //     _currentIndex = index;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) { 
//     return Scaffold(
//       body: _tabs[_currentIndex],
//       bottomNavigationBar: NavigationBar(
//         selectedIndex: _currentIndex,
//         onDestinationSelected: (int index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         backgroundColor: Colors.white,
//         indicatorColor: const Color.fromARGB(255, 211, 227, 253),
//         surfaceTintColor: const Color.fromARGB(255, 240, 243, 248),
//         elevation: 20,
//         height: 70,
//         destinations: [
//           NavigationDestination(
//             icon: Icon(
//               Icons.location_on_outlined,
//               color: Colors.grey[600],
//             ),
//             selectedIcon: const Icon(
//               Icons.location_on,
//               color: Color.fromARGB(255, 15, 84, 206),
//               // color: Colors.black,
//             ),
//             label: 'Explore',
//             tooltip: 'Explore',
//           ),
//           NavigationDestination(
//             icon: Icon(
//               Icons.calendar_month_outlined,
//               color: Colors.grey[600],
//             ),
//             selectedIcon: const Icon(
//               Icons.calendar_month,
//               color: Color.fromARGB(255, 15, 84, 206),

//               // color: Colors.black,
//             ),
//             label: 'Records',
//             tooltip: 'Records',
//           ),
//           NavigationDestination(
//             icon: Icon(
//               Icons.person_outline,
//               color: Colors.grey[600],
//             ),
//             selectedIcon: const Icon(
//               Icons.person,
//               color: Color.fromARGB(255, 15, 84, 206),

//               // color: Colors.black,
//             ),
//             label: 'Profile',
//             tooltip: 'Profile',
//           ),
//         ],
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   // iconSize: 30,
//       //   // backgroundColor: Colors.grey[200],
//       //   elevation: 50,
//       //   backgroundColor: Colors.white,
//       //   selectedItemColor: Colors.black,
//       //   unselectedItemColor: Colors.grey[600],
//       //   onTap: onTabTapped,
//       //   currentIndex: _currentIndex,
//       //   items: [
//       //     BottomNavigationBarItem(
//       //       // 1
//       //       icon: Icon(
//       //         Icons.location_on_outlined,
//       //         color: Colors.grey[600],
//       //       ),
//       //       activeIcon: const Icon(
//       //         Icons.location_on,
//       //         color: Colors.black,
//       //       ),
//       //       label: 'Explore',
//       //       tooltip: 'Explore',
//       //     ),
//       // BottomNavigationBarItem(
//       //   // 2
//       //   icon: Icon(
//       //     Icons.calendar_month_outlined,
//       //     color: Colors.grey[600],
//       //   ),
//       //   activeIcon: const Icon(
//       //     Icons.calendar_month,
//       //     color: Colors.black,
//       //   ),
//       //   label: 'Records',
//       //   tooltip: 'Records',
//       // ),
//       //     BottomNavigationBarItem(
//       //       // 3
//       //       icon: Icon(
//       //         Icons.person_outline,
//       //         color: Colors.grey[600],
//       //       ),
//       //       activeIcon: const Icon(
//       //         Icons.person,
//       //         color: Colors.black,
//       //       ),
//       //       label: 'Profile',
//       //       tooltip: 'Profile',
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// }
