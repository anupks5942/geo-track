import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isBusy;
  final bool isEnabled;
  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isBusy = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isBusy ? () {} : onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          // horizontal: 8.w,
          vertical: 7.h,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 27, 109, 244),
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: isBusy
            ? SizedBox(
                width: 20.sp,
                height: 20.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: GoogleFonts.sora(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
              ),
      ),
    );
  }
}
