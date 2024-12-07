import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geo_track/pages/features/analytics/calender_records.dart';
import 'package:geo_track/pages/features/analytics/daily_statistics.dart';
import 'package:geo_track/pages/features/analytics/letter.dart';
import 'package:geo_track/pages/features/analytics/working_statistics.dart';
import 'package:geo_track/pages/others/profile.dart';
import 'package:geo_track/pages/others/settings.dart';
import 'package:geo_track/utils/animated_navigation.dart';
import 'package:geo_track/widgets/features/analytics/neumorphism_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NeumorphismCard(
                  icon: Icons.bar_chart,
                  title: "Working Statistics",
                  onTap: () {
                    Navigator.of(context).push(
                      AnimatedNavigation().rightToLeftTransition(
                          const WorkingStatisticsScreen()),
                    );
                  },
                ),
                NeumorphismCard(
                  icon: Icons.calendar_month_outlined,
                  title: "Calender Records",
                  onTap: () {
                    Navigator.of(context).push(
                      AnimatedNavigation()
                          .rightToLeftTransition(const CalenderRecordsScreen()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
              // height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NeumorphismCard(
                  icon: Icons.data_exploration_outlined,
                  title: "Daily Statistics",
                  onTap: () {
                    Navigator.of(context).push(
                      AnimatedNavigation()
                          .rightToLeftTransition(const DailyStatisticsScreen()),
                    );
                  },
                ),
                NeumorphismCard(
                  icon: Icons.mail_outline,
                  title: "Letter to HR",
                  onTap: () {
                    Navigator.of(context).push(
                      AnimatedNavigation()
                          .rightToLeftTransition(const LetterScreen()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
              // height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NeumorphismCard(
                  icon: Icons.person,
                  title: "Profile",
                  onTap: () {
                    Navigator.of(context).push(
                      AnimatedNavigation()
                          .rightToLeftTransition(const ProfileScreen()),
                    );
                  },
                ),
                NeumorphismCard(
                  icon: Icons.settings,
                  title: "Settings",
                  onTap: () {
                    Navigator.of(context).push(
                      AnimatedNavigation()
                          .rightToLeftTransition(const SettingsScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
