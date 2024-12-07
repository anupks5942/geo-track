import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
      visualDensity: const VisualDensity(vertical: -4),
      leading: Icon(
        leadingIcon,
        size: 20.sp,
        // size: width * 0.06,
      ),
      title: Text(
        title,
      ),
      subtitle: Text(
        subtitle,
      ),
      onTap: onTap,
    );
  }
}
