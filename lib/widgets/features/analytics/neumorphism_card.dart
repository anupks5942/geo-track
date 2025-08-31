import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NeumorphismCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const NeumorphismCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final shadowColor = Theme.of(context).brightness == Brightness.light
        ? Colors.grey[500]!
        : Colors.black;
    final highlightColor = Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : Colors.grey[800]!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        height: 150.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(4, 4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: highlightColor,
              offset: const Offset(-4, -4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: EdgeInsets.all(12.w),
        child: Center(
          child: Column(
            children: [
              Icon(
                icon,
                size: 50.sp,
              ),
              const Spacer(),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
