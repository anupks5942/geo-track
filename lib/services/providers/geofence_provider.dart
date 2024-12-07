import 'package:flutter/material.dart';
import 'package:geo_track/services/settings/notification_service.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:math' hide log;

class GeofenceProvider with ChangeNotifier {
  bool isInsideGeofence = false;
  late StreamSubscription<LocationData> positionStream;
  final Location location = Location();
  // List userLocation = [];

  // Geofence-related variables
  List<double> temp = [];
  List<double> _officeLocation = [23.182200, 77.454801];
  // List<double> _officeLocation = [23.293351, 77.379405];
  LatLng _geofenceCenter =
      const LatLng(23.182200, 77.454801); // Geofence center
  double _geofenceRadius = 200.0; // Geofence radius in meters

  Future<void> startGeofenceTracking() async {
    positionStream = location.onLocationChanged.listen((position) {
      _checkGeofence(position);
    });
  }

  void _checkGeofence(LocationData position) {
    double lat1 = _geofenceCenter.latitude;
    double lon1 = _geofenceCenter.longitude;
    double? lat2 = position.latitude;
    double? lon2 = position.longitude;

    var R = 6371e3; // metres
    // var R = 1000;
    var phi1 = (lat1 * pi) / 180; // φ, λ in radians
    var phi2 = (lat2! * pi) / 180;
    var deltaPhi = ((lat2 - lat1) * pi) / 180;
    var deltaLambda = ((lon2! - lon1) * pi) / 180;

    var a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);

    var c = 2 * atan2(sqrt(a), sqrt(1 - a));

    var d = R * c;

    log("Position: ${position.latitude}, ${position.longitude}");
    log("Distance: $d meters");

    if (d <= _geofenceRadius) {
      if (!isInsideGeofence) {
        _updateIsInsideGeofence(true);
        NotificationService().showCheckInNotification(
            id: 1000,
            title: "⤵️ Checked-In!",
            body:
                "At Main Office, ${DateFormat('hh:mm:ss a').format(DateTime.now())}",
            payload: "checked-in");
      }
    } else {
      if (isInsideGeofence) {
        _updateIsInsideGeofence(false);
        NotificationService().showCheckOutNotification(
            id: 1001,
            title: "⤴️ Checked-Out!",
            body: "Tap to submit your absence reason",
            payload: "checked-out");
      }
    }
    log(isInsideGeofence.toString());
  }

  void setGeofenceCenter(String value, BuildContext context) {
    temp = value.split(',').map((item) => double.parse(item.trim())).toList();
    _geofenceRadius = temp[2];
    _officeLocation = [temp[0], temp[1]];
    _geofenceCenter = LatLng(temp[0], temp[1]);
    notifyListeners();
  }

  void getGeofenceCenter(
      String p0, TextEditingController controller, BuildContext context) {
    String coordinates = p0
        .split('(')[1]
        .split(')')[0]
        .toString(); // 23.2932144, 77.3793604, 0.0
    List<String> parts =
        coordinates.split(','); // [23.2932144, 77.3793604, 0.0]
    parts[2] = " 200";
    controller.text = parts.join(',');

    temp = controller.text
        .split(',')
        .map((item) => double.parse(item.trim()))
        .toList();
    _geofenceRadius = temp[2];
    _officeLocation = [temp[0], temp[1]];
    _geofenceCenter = LatLng(temp[0], temp[1]);
    notifyListeners();
  }

  void _updateIsInsideGeofence(bool value) {
    if (isInsideGeofence != value) {
      isInsideGeofence = value;

      notifyListeners();
    }
  }

  List<double> get officeLocation => _officeLocation;
  double get geofenceRadius => _geofenceRadius;
}
