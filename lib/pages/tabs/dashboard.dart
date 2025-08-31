import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geo_track/pages/features/analytics/calender_records.dart';
import 'package:geo_track/pages/features/analytics/daily_analytics.dart';
import 'package:geo_track/pages/features/analytics/letter.dart';
import 'package:geo_track/pages/features/analytics/working_statistics.dart';
import 'package:geo_track/pages/others/profile.dart';
import 'package:geo_track/pages/others/settings.dart';
import 'package:geo_track/utils/animated_navigation.dart';
import 'package:geo_track/widgets/features/analytics/neumorphism_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:geo_track/services/providers/geofence_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height, // Full screen height
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Consumer<GeofenceProvider>(
              builder: (context, provider, child) {
                final isCheckedIn = provider.isInsideGeofence;
                final checkInTime = provider.checkInTime;

                log(isCheckedIn.toString());

                return Column(
                  children: [
                    Text(
                      isCheckedIn ? 'Currently Working' : 'Checked Out',
                      style: GoogleFonts.sora(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: isCheckedIn ? Colors.green : Colors.red,
                      ),
                    ),
                    if (isCheckedIn) ...[
                      SizedBox(height: 10.h),
                      Text(
                        provider.elapsedTime,
                        style: GoogleFonts.sora(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          // fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Check In: ',
                              style: GoogleFonts.sora(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: _formatDateTime(checkInTime),
                                  style: GoogleFonts.sora(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                    // fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      SizedBox(height: 10.h),
                      Text(
                        '00:00:00',
                        style: GoogleFonts.sora(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          // fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text.rich(
                        TextSpan(
                          text: 'Total Hours: ',
                          style: GoogleFonts.sora(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: provider.totalWorkingHours,
                              style: GoogleFonts.sora(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                // fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
            SizedBox(height: 10.h),
            const Divider(),
            SizedBox(height: 10.h),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                            AnimatedNavigation().rightToLeftTransition(
                                const CalenderRecordsScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      NeumorphismCard(
                        icon: Icons.data_exploration_outlined,
                        title: "Daily Analytics",
                        onTap: () {
                          Navigator.of(context).push(
                            AnimatedNavigation().rightToLeftTransition(
                                const DailyAnalyticsScreen()),
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
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return DateFormat('hh:mm a').format(dateTime);
  }
}
