import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoTile extends StatelessWidget {
  final IconData leadingIcon;
  final String label;
  final String value;
  // final VoidCallback onEdit;

  const InfoTile({
    super.key,
    required this.leadingIcon,
    required this.label,
    required this.value,
    // required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          visualDensity: const VisualDensity(vertical: -4),
          leading: Icon(
            leadingIcon,
            size: 20.sp,
            // size: width * 0.06,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 10.sp,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        Divider(
          indent: 48.w, // Adjust divider indent as needed
          // indent: width * 0.12, // Adjust divider indent as needed
        ),
      ],
    );
  }
}
