import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geo_track/pages/tabs/permission.dart';
import 'package:geo_track/pages/tabs/map_screen.dart';
import 'package:geo_track/utils/utils.dart';
// import 'package:geo_track/utils/utils.dart';
import 'package:geo_track/widgets/features/permission/toast.dart';
import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider extends ChangeNotifier {
  bool locationAllowedAlways = false,
      locationService = false,
      notificationAllowed = false,
      cameraAllowed = false;

  // LocationData? locationData;
  Location location = Location();
  bool isSearching = false;

  Future<void> updatePermissions() async {
    locationAllowedAlways = await Permission.locationAlways.isGranted;
    locationService = await location.serviceEnabled();
    notificationAllowed = await Permission.notification.isGranted;
    cameraAllowed = await Permission.camera.isGranted;

    log("$locationAllowedAlways $locationService $notificationAllowed $cameraAllowed");
    notifyListeners();
  }

  Future<void> loadInitialScreen(BuildContext context) async {
    locationAllowedAlways = await Permission.locationAlways.isGranted;
    locationService = await location.serviceEnabled();
    notificationAllowed = await Permission.notification.isGranted;
    cameraAllowed = await Permission.camera.isGranted;

    if (locationAllowedAlways &&
        locationService &&
        notificationAllowed &&
        cameraAllowed) {
      Utils.removeAllAndPush(context, const MapScreen());
    } else {
      Utils.removeAllAndPush(context, const PermissionScreen());
    }
    notifyListeners();
  }

  Future<void> checkPermission(context) async {
    updatePermissions();

    if (locationAllowedAlways &&
        locationService &&
        notificationAllowed &&
        cameraAllowed) {
      Utils.removeAllAndPush(context, MapScreen());
    } else {
      Toasts().showToast(
          context, Icons.error_outline, "Please enable remaining permissions");
    }
    notifyListeners();
  }

  Future<void> requestLocationPermission(context) async {
    PermissionStatus locationStatus = await Permission.location.request();

    if (locationStatus.isGranted) {
      PermissionStatus alwaysStatus = await Permission.locationAlways.request();

      if (alwaysStatus.isGranted) {
        locationAllowedAlways = true;
      } else if (alwaysStatus.isDenied) {
        log("always-location denied");
      } else {
        Toasts().openSettingsToast(context, Icons.location_on,
            "Tap here & select 'Allow all the time' inside location");
      }
    } else if (locationStatus.isDenied) {
      log("location denied");
    } else {
      Toasts().openSettingsToast(context, Icons.location_on,
          "Tap here & select 'Allow all the time' inside location");
    }
    notifyListeners();
  }

  Future<void> requestLocationService(context) async {
    if (locationAllowedAlways) {
      locationService = await location.requestService();
    } else {
      Toasts().showToast(
          context, Icons.location_on, "Allow 'Always on Location' first");
    }
    notifyListeners();
  }

  Future<void> requestNotificationPermission(context) async {
    PermissionStatus notificationStatus =
        await Permission.notification.request();

    if (notificationStatus.isGranted) {
      notificationAllowed = true;
    } else if (notificationStatus.isDenied) {
      log("notification denied");
    } else {
      Toasts().openSettingsToast(context, Icons.notifications_active,
          "Tap here & allow notification permission");
    }
    notifyListeners();
  }

  Future<void> requestCameraPermission(context) async {
    PermissionStatus cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      cameraAllowed = true;
    } else if (cameraStatus.isDenied) {
      log("camera denied");
    } else {
      Toasts().openSettingsToast(
          context, Icons.camera_alt, "Tap here & allow camera permission");
    }
    notifyListeners();
  }

  Future<void> requestPermissions() async {
    PermissionStatus locationStatus = await Permission.location.request();

    if (locationStatus.isGranted) {
      PermissionStatus alwaysStatus = await Permission.locationAlways.request();
      locationAllowedAlways = alwaysStatus.isGranted;

      if (locationAllowedAlways) {
        locationService = await location.requestService();

        notificationAllowed = await Permission.notification.request().isGranted;

        cameraAllowed = await Permission.camera.request().isGranted;
      }
    }

    notifyListeners();
  }
  // Future<void> requestPermissions(context) async {
  //   PermissionStatus locationStatus = await Permission.location.request();
  //   if (locationStatus.isGranted) {
  //     PermissionStatus alwaysStatus = await Permission.locationAlways.request();
  //     if (alwaysStatus.isGranted) {
  //       await Location().requestService();
  //       bool locationService = await location.serviceEnabled();
  //       await Permission.notification.request();
  //       PermissionStatus notificationStatus =
  //           await Permission.notification.status;
  //       if (locationService && notificationStatus.isGranted) {
  //         Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => const MapScreen(),
  //         ));
  //       }
  //       if (notificationStatus.isDenied ||
  //           notificationStatus.isPermanentlyDenied) {
  //         openAppSettings();
  //       }
  //     }
  //   } else if (locationStatus.isDenied) {
  //   } else {
  //     openAppSettings();
  //   }
  //   notifyListeners();
  // }
}
