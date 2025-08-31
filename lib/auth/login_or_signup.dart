import 'package:google_fonts/google_fonts.dart';
import 'package:geo_track/auth/login.dart';
import 'package:geo_track/auth/sign_up.dart';
import 'package:geo_track/services/functions/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInOrSignUp extends StatelessWidget {
  const LogInOrSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 8.h,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.watch<AuthProvider>().hasSelectedSignUpView
                      ? "Sign up"
                      : "Log in",
                  style: GoogleFonts.sora(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                Consumer<AuthProvider>(
                  builder: (context, value, _) {
                    return value.hasSelectedSignUpView
                        ? const SignUpView()
                        : const LogInView();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
