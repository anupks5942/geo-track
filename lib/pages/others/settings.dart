import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geo_track/auth/login_or_signup.dart';
import 'package:geo_track/services/functions/auth_service.dart';
import 'package:geo_track/services/settings/theme_notifier.dart';
import 'package:geo_track/utils/custom_exception.dart';
import 'package:geo_track/utils/utils.dart';
import 'package:geo_track/widgets/features/settings/settings_tile.dart';
import 'package:geo_track/pages/features/settings/theme_popup.dart';

import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void logOut() async {
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          ),
          TextButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Log out',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
    if (shouldSignOut == true) {
      try {
        await AuthService().signOut();
        Utils.removeAllAndPush(context, const LogInOrSignUp());
      } on CustomException catch (e) {
        Utils.alertUser(
          context,
          e.message,
          Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
      ),
      body: Column(
        children: [
          SettingsTile(
            leadingIcon: Icons.brightness_6_outlined,
            title: "Theme",
            subtitle: themeNotifier.currentTheme.name,
            onTap: () => ThemePopup().showThemeDialog(context),
          ),
          SettingsTile(
            leadingIcon: Icons.language,
            title: "App language",
            subtitle: "English (device's language)",
            onTap: () {},
          ),
          SettingsTile(
            leadingIcon: Icons.logout,
            title: "Log Out",
            subtitle: "Log out from this device",
            onTap: logOut,
          ),
        ],
      ),
    );
  }
}
