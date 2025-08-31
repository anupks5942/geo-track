import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geo_track/services/functions/auth_provider.dart';
import 'package:geo_track/utils/validators.dart';
import 'package:geo_track/widgets/features/auth/action_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _onActionButtonTap() {
    // Don't do anything if any of the fields are invalid
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    context
        .read<AuthProvider>()
        .resetPassword(_emailController.text.trim(), context);

    setState(() {
      _emailController.clear();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              children: [
                Text(
                  "Forgot Password",
                  style: GoogleFonts.sora(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "We'll send you an email with a link to reset your password if it matches an existing account.",
                  style: GoogleFonts.sora(
                    fontSize: 12.sp,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    style: GoogleFonts.sora(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    controller: _emailController,
                    validator: Validators.validateEmail,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Consumer<AuthProvider>(
                  builder: (context, value, _) => ActionButton(
                    text: "Send link",
                    isBusy: value.isBusy,
                    onPressed: _onActionButtonTap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
