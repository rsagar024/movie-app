import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:movie_app/core/utils/uni_services.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Static method for background notification handling
  static Future<void> onDidReceiveBackgroundNotificationResponse(NotificationResponse notificationResponse) async {
    print('It invoke');
    await UniServices.uniHandler(Uri.parse(notificationResponse.payload!));
  }

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('my_app');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
        int id,
        String? title,
        String? body,
        String? payload,
      ) async {},
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) async {
        // print(notificationResponse.payload);
        // Database notifyDatabase = await NotificationDatabaseMethods().notifyDatabase;
        // var notify = await NotificationDatabaseMethods().getNotifyList();

        UniServices.uniHandler(Uri.parse(notificationResponse.payload!));
      },
      // onDidReceiveBackgroundNotificationResponse: (NotificationResponse notificationResponse) async {
      //   await UniServices.uniHandler(Uri.parse(notificationResponse.payload!));
      // },
      // Use the static method for background notification response
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
    );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        icon: '@drawable/my_app',
        importance: Importance.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: payload,
    );
  }
}
