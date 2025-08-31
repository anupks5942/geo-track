import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geo_track/utils/animated_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geo_track/auth/forgot_pass.dart';
import 'package:geo_track/services/functions/auth_provider.dart';
import 'package:geo_track/utils/validators.dart';
import 'package:geo_track/widgets/features/auth/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  _LogInViewState createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _email;
  String? _password;

  _onActionButtonTap() {
    log("Login button tapped");

    if (!_formKey.currentState!.validate()) {
      log("Form validation failed");
      return;
    }

    _formKey.currentState!.save();

    log("Email: $_email");
    log("Password: $_password");

    context.read<AuthProvider>().signInUsingEmailAndPassword(
          email: _email!,
          password: _password!,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            style: GoogleFonts.sora(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            validator: Validators.validateEmail,
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
            onSaved: (value) {
              _email = value;
            },
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          SizedBox(height: 5.h),
          TextFormField(
            controller: _passwordController,
            style: GoogleFonts.sora(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: TextInputType.visiblePassword,
            validator: Validators.validatePassword,
            obscureText: !_passwordVisible,
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
            onSaved: (value) {
              _password = value;
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              hintText: "Password",
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  AnimatedNavigation()
                      .rightToLeftTransition(const ForgotPassScreen()),
                ),
                child: Text(
                  "Forgot password?",
                  style: GoogleFonts.sora(
                    color: Colors.blue,
                    fontSize: 11.sp,
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Consumer<AuthProvider>(
            builder: (context, value, _) {
              return ActionButton(
                text: "Log in",
                isBusy: value.isBusy,
                onPressed: _onActionButtonTap,
              );
            },
          ),
          SizedBox(height: 15.h),
          Text(
            "Don't have an account?",
            style: GoogleFonts.sora(
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: context.read<AuthProvider>().toggleAuthView,
            child: Container(
              padding: EdgeInsets.symmetric(
                // horizontal: 8.w,
                vertical: 7.h,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[400],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  "Sign up",
                  style: GoogleFonts.sora(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
