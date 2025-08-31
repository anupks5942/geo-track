import 'package:flutter/material.dart';
import 'package:geo_track/services/settings/notification_service.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:math' hide log;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GeofenceProvider with ChangeNotifier {
  bool isInsideGeofence = false;
  late StreamSubscription<LocationData> positionStream;
  final Location location = Location();

  List<double> temp = [];
  List<double> _officeLocation = [
    23.182200,
    77.454801
  ];
  // List<double> _officeLocation = [23.293351, 77.379405];
  LatLng _geofenceCenter = const LatLng(23.182200, 77.454801); // Geofence center
  double _geofenceRadius = 200.0; // Geofence radius in meters

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _currentRecordId;

  DateTime? _checkInTime;
  Duration _totalWorkingDuration = Duration.zero;
  Timer? _timer;

  List<double> get officeLocation => _officeLocation;
  double get geofenceRadius => _geofenceRadius;
  DateTime? get checkInTime => _checkInTime;

  String get elapsedTime {
    if (_checkInTime == null) return '00:00:00';
    return _formatDuration(_totalWorkingDuration);
  }

  String get totalWorkingHours => _formatDuration(_totalWorkingDuration);

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

    var a = sin(deltaPhi / 2) * sin(deltaPhi / 2) + cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);

    var c = 2 * atan2(sqrt(a), sqrt(1 - a));

    var d = R * c;

    log("Position: ${position.latitude}, ${position.longitude}");
    log("Distance: $d meters");

    final bool shouldBeInside = d <= _geofenceRadius;

    if (shouldBeInside != isInsideGeofence) {
      _updateIsInsideGeofence(shouldBeInside);

      if (shouldBeInside) {
        _sendCheckInNotification();
      } else {
        _sendCheckOutNotification();
      }
    }
    log(isInsideGeofence.toString());
  }

  Future<void> _sendCheckInNotification() async {
    _checkInTime = DateTime.now();
    _startTimer();

    // Get current user email and create doc ID
    final userEmail = _auth.currentUser?.email;
    if (userEmail == null) return;

    final docName = userEmail.split('@')[0];
    _currentRecordId = DateTime.now().millisecondsSinceEpoch.toString();

    // Calculate existing total hours first
    await calculateTodayWorkingHours();

    // Store the current total as base for new calculations
    final baseHours = _totalWorkingDuration;

    // Update timer to include existing hours
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_checkInTime != null) {
        final currentSession = DateTime.now().difference(_checkInTime!);
        final totalDuration = baseHours + currentSession;
        _totalWorkingDuration = totalDuration;
        notifyListeners();
      }
    });

    // Create attendance record
    await _firestore.collection('users').doc(docName).collection('attendanceRecords').doc(_currentRecordId).set({
      'record_id': _currentRecordId,
      'check_in_time': DateTime.now().toIso8601String(),
      'check_in_location': {
        'latitude': _geofenceCenter.latitude,
        'longitude': _geofenceCenter.longitude,
      },
    });

    // Show notification
    NotificationService().showCheckInNotification(
      id: 1000,
      title: "⤵️ Checked-In!",
      body: "At Main Office, ${DateFormat('hh:mm:ss a').format(DateTime.now())}",
      payload: "checked-in",
    );
  }

  Future<void> _sendCheckOutNotification({String? reason}) async {
    _stopTimer();
    _checkInTime = null;

    // Get current user email
    final userEmail = _auth.currentUser?.email;
    if (userEmail == null || _currentRecordId == null) return;

    final docName = userEmail.split('@')[0];

    // Update attendance record with check-out data
    await _firestore.collection('users').doc(docName).collection('attendanceRecords').doc(_currentRecordId).update({
      'check_out_time': DateTime.now().toIso8601String(),
      'check_out_location': {
        'latitude': _geofenceCenter.latitude,
        'longitude': _geofenceCenter.longitude,
      },
      'check_out_reason': reason ?? 'Left geofence area',
    });

    // Reset current record ID
    _currentRecordId = null;

    // Show notification
    NotificationService().showCheckOutNotification(
      id: 1001,
      title: "⤴️ Checked-Out!",
      body: "Tap to submit your absence reason",
      payload: "checked-out",
    );

    // Calculate updated total hours
    await calculateTodayWorkingHours();
  }

  void setGeofenceCenter(String value, BuildContext context) {
    temp = value.split(',').map((item) => double.parse(item.trim())).toList();
    _geofenceRadius = temp[2];
    _officeLocation = [
      temp[0],
      temp[1]
    ];
    _geofenceCenter = LatLng(temp[0], temp[1]);
    notifyListeners();
  }

  void getGeofenceCenter(String p0, TextEditingController controller, BuildContext context) {
    String coordinates = p0.split('(')[1].split(')')[0].toString(); // 23.2932144, 77.3793604, 0.0
    List<String> parts = coordinates.split(','); // [23.2932144, 77.3793604, 0.0]
    parts[2] = " 200";
    controller.text = parts.join(',');

    temp = controller.text.split(',').map((item) => double.parse(item.trim())).toList();
    _geofenceRadius = temp[2];
    _officeLocation = [
      temp[0],
      temp[1]
    ];
    _geofenceCenter = LatLng(temp[0], temp[1]);
    notifyListeners();
  }

  void _updateIsInsideGeofence(bool value) {
    if (isInsideGeofence != value) {
      isInsideGeofence = value;

      notifyListeners();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_checkInTime != null) {
        // Update total working duration with the current session
        _totalWorkingDuration = _totalWorkingDuration + const Duration(seconds: 1);
        notifyListeners();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  Future<void> calculateTodayWorkingHours() async {
    final userEmail = _auth.currentUser?.email;
    if (userEmail == null) return;

    final docName = userEmail.split('@')[0];
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    try {
      final querySnapshot = await _firestore.collection('users').doc(docName).collection('attendanceRecords').where('check_in_time', isGreaterThanOrEqualTo: startOfDay.toIso8601String()).where('check_in_time', isLessThan: endOfDay.toIso8601String()).get();

      Duration totalDuration = Duration.zero;

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        if (data['check_in_time'] != null && data['check_out_time'] != null) {
          final checkIn = DateTime.parse(data['check_in_time']);
          final checkOut = DateTime.parse(data['check_out_time']);
          totalDuration += checkOut.difference(checkIn);
        }
      }

      _totalWorkingDuration = totalDuration;
      notifyListeners();
    } catch (e) {
      log('Error calculating working hours: $e');
    }
  }

  Future<void> manualCheckOut(String reason) async {
    await _sendCheckOutNotification(reason: reason);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
