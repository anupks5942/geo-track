import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:geo_track/pages/tabs/analytics.dart';
import 'package:geo_track/pages/tabs/map_screen.dart';
import 'dart:developer';
import 'package:geo_track/utils/constants.dart';

void backgroundNotificationResponseHandler(
    NotificationResponse notification) async {
  log('Received background notification response: $notification');
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification(BuildContext context) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');

    const DarwinInitializationSettings initializationSettingIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      defaultPresentSound: true,
      defaultPresentAlert: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification: (id, title, body, payload) async {
      //   log('Received local notification: $id, $title, $body, $payload');
      // },
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingIOS,
    );

    await notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log('Received notification response: ${response.payload}');

        if (response.payload == 'checked-out') {
          log("...................................................................");
          fromNoti = true;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MapScreen()),
          );
          // navigatorKey.currentState?.pushReplacement(
          //   MaterialPageRoute(builder: (context) => const MapScreen()),
          // );
        }
        // else {
        //   log("*******************************************************************");
        //   navigatorKey.currentState?.pushReplacement(
        //     MaterialPageRoute(builder: (context) => const AnalyticsScreen()),
        //   );
        // }
      },
      onDidReceiveBackgroundNotificationResponse:
          backgroundNotificationResponseHandler,
    );
  }

  Future<void> showCheckInNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    log('Showing notification: $id, $title, $body, $payload');
    await notificationPlugin.show(
      id,
      title,
      body,
      await checkInNotificationDetails(),
      payload: payload,
    );
  }

  Future<void> showCheckOutNotification({
    int id = 1,
    String? title,
    String? body,
    String? payload,
  }) async {
    log('Showing notification: $id, $title, $body, $payload');
    await notificationPlugin.show(
      id,
      title,
      body,
      await checkOutNotificationDetails(),
      payload: payload,
    );
  }

  Future<NotificationDetails> checkInNotificationDetails() async {
    return const NotificationDetails(
      iOS: DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'checkInChannelId',
        'checkInChannelName',
        importance: Importance.max,
        priority: Priority.high,
        // color: Colors.white,
      ),
    );
  }

  Future<NotificationDetails> checkOutNotificationDetails() async {
    return const NotificationDetails(
      iOS: DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        'checkOutChannelId',
        'checkOutChannelName',
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true, // locked
        // autoCancel: false, // touch krne pe nhi hategi
        // color: Colors.white,
      ),
    );
  }
}
