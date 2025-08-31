import 'package:flutter/material.dart';
import 'package:geo_track/services/settings/theme_notifier.dart';
import 'package:geo_track/services/settings/app_theme.dart';
import 'package:provider/provider.dart';

class ThemePopup {
  void showThemeDialog(BuildContext context) {
    final themeNotifier = context.read<ThemeNotifier>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        AppTheme selectedTheme = themeNotifier.themeType;

        return AlertDialog(
          title: const Text('Choose theme'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: AppTheme.values.map((theme) {
                  return RadioListTile<AppTheme>(
                    title: Text(theme.name),
                    value: theme,
                    groupValue: selectedTheme,
                    onChanged: (value) {
                      setState(() {
                        selectedTheme = value!;
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                themeNotifier.setTheme(selectedTheme, context);
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
