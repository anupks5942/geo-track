import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PermissionTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final bool permissionGranted;
  final String actionText;
  final VoidCallback onPressed;

  const PermissionTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.permissionGranted,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        visualDensity: const VisualDensity(vertical: -4),
        leading: Icon(
          leadingIcon,
          size: 25.sp,
        ),
        title: Text(
          title,
          style: GoogleFonts.sora(
            fontSize: 14.sp,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.sora(
            fontSize: 10.sp,
          ),
        ),
        trailing: permissionGranted
            ? Icon(
                Icons.check,
                color: Colors.green,
                size: 25.sp,
              )
            : TextButton(
                onPressed: onPressed,
                child: Text(
                  actionText,
                ),
              ),
      ),
    );
  }
}
