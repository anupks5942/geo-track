import 'package:flutter/material.dart';

class AnimatedNavigation {
  Route rightToLeftTransition(nextScreen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide in from the right
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  // Route delayTransition(nextScreen) {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
  //       body: FutureBuilder(
  //         future: Future.delayed(
  //             const Duration(milliseconds: 100)), // Adjust delay if needed
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.done) {
  //             return nextScreen; // Load map after delay
  //           } else {
  //             return Container(); //
  //           }
  //         },
  //       ),
  //     ),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       final opacityAnimation =
  //           Tween<double>(begin: 0.0, end: 1.0).animate(animation);
  //       return SlideTransition(
  //         position: Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
  //             .animate(animation),
  //         child: FadeTransition(opacity: opacityAnimation, child: child),
  //       );
  //     },
  //   );
  // }

  Route expandTransition(nextScreen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var scaleAnimation = animation.drive(tween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    );
  }
}
