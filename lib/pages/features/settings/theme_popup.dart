import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geo_track/services/settings/theme_notifier.dart';

import 'package:provider/provider.dart';

class ThemePopup {
  void showThemeDialog(BuildContext context) {
    final themeNotifier = context.read<ThemeNotifier>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        AppTheme? selectedTheme = themeNotifier.currentTheme;

        return AlertDialog(
          title: const Text(
            'Choose theme',
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: AppTheme.values.map((theme) {
                  return RadioListTile<AppTheme>(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.w),
                    visualDensity: const VisualDensity(vertical: -4),
                    title: Text(
                      theme.name,
                    ), // Use the extension method
                    value: theme,
                    groupValue: selectedTheme,
                    onChanged: (value) {
                      setState(() {
                        selectedTheme = value; // Update selected theme
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              ),
              onPressed: () {
                Navigator.pop(context); // Cancel button
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: const Color.fromARGB(255, 27, 109, 244),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (selectedTheme != null) {
                  themeNotifier.setTheme(selectedTheme!, context);
                }
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  color: const Color.fromARGB(255, 27, 109, 244),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
