import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Utils {
  // static navigateTo(Widget destination) {
  //   try {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => destination),
  //     );
  //   } catch (e) {
  //     log("Error while navigating : $e");
  //   }
  // }

  static removeAllAndPush(BuildContext context, Widget destination) {
    try {
      Navigator.of(context).pushReplacement(
        // AnimatedNavigation().rightToLeftTransition(destination),
        MaterialPageRoute(builder: (context) => destination),
      );
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (context) => destination),
      //   (route) => false,
      // );
    } catch (e) {
      log("Error while navigating : $e");
    }
  }

  static alertUser(BuildContext context, String msg, Color color) =>
      _showDialog(
        context,
        message: msg,
        color: color,
      );

  static _showDialog(
    BuildContext context, {
    required String message,
    required Color color,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          message,
          style: GoogleFonts.sora(fontSize: 12.sp, color: color),
        ),
        actions: [
          TextButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Cancel button
            },
            child: Text(
              'Ok',
              style: GoogleFonts.sora(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
