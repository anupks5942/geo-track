import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geo_track/widgets/features/permission/permission_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:geo_track/services/providers/permission_provider.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    context.read<PermissionProvider>().requestPermissions();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<PermissionProvider>().updatePermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    final permissionWatch = context.watch<PermissionProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 8.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox(
              //   height: height * 0.01,
              // ),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              Text(
                'Permissions',
                style: GoogleFonts.sora(
                  fontSize: 20.sp,
                  // fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              // SizedBox(height: height * 0.01),
              Text(
                "These permissions are required for the app to function properly. Please allow access to continue.",
                style: GoogleFonts.sora(
                  fontSize: 12.sp,
                  // fontSize: width * 0.035,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              PermissionTile(
                leadingIcon: Icons.location_on_outlined,
                title: "Always on Location",
                subtitle: "Allow access to Background Location",
                permissionGranted: permissionWatch.locationAllowedAlways,
                actionText: 'Allow',
                onPressed: () => context
                    .read<PermissionProvider>()
                    .requestLocationPermission(context),
              ),
              PermissionTile(
                leadingIcon: Icons.my_location_outlined,
                title: "Location Service",
                subtitle: "Turn on Location Service",
                permissionGranted: permissionWatch.locationService,
                actionText: 'Turn on',
                onPressed: () => context
                    .read<PermissionProvider>()
                    .requestLocationService(context),
              ),
              PermissionTile(
                leadingIcon: Icons.notifications_active_outlined,
                title: "Push Notifications",
                subtitle: "Allow access to Notifications",
                permissionGranted: permissionWatch.notificationAllowed,
                actionText: 'Allow',
                onPressed: () => context
                    .read<PermissionProvider>()
                    .requestNotificationPermission(context),
              ),
              PermissionTile(
                leadingIcon: Icons.camera_alt_outlined,
                title: "Camera",
                subtitle: "Allow access to Camera",
                permissionGranted: permissionWatch.cameraAllowed,
                actionText: 'Allow',
                onPressed: () => context
                    .read<PermissionProvider>()
                    .requestCameraPermission(context),
              ),
              //       ],
              //     ),
              //   ),
              // ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  context.read<PermissionProvider>().checkPermission(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 27, 109, 244),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Continue',
                    style: GoogleFonts.sora(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
