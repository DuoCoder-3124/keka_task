import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:keka_task/common_attribute/common_log.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as latest;

class FirebaseService {


  static FirebaseService helper = FirebaseService._();

  FirebaseService._();

  var firebaseMessaging=FirebaseMessaging.instance;

  Future<String?> connectFirebase() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    firebaseMessaging.subscribeToTopic('allTopics');
    // NotificationService.notificationService.initLocalNotification();
    return FirebaseMessaging.instance.getToken().then(
      (value) {
        var fcmToken = value;
        Log.success("FCM Token: $value");
        return fcmToken;
      },
    );
  }


  ///msg notifyListen
  void firebaseNotify() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("NotificationOnMessage=======>${message.notification?.title}");
      initLocalNotification();
      sendLocalNotification(
        title: message.notification?.title ?? "",
        body: message.notification?.body ?? "",
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("NotificationOnMessage=======>>>${message.notification?.title}");
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      debugPrint("NotificationOnBackgroundMessage=======>${message.notification?.title}");
      return await null;
    });
  }

  ///InitializationNotification after create sentNotification
  void initLocalNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings darwinInitializationSettings = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );
    latest.initializeTimeZones();
    await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
  }

  ///sendNotificationOnDevice
  Future<void> sendLocalNotification({required String title, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "1",
      title,
      channelDescription: body,
      importance: Importance.high,
      priority: Priority.high,
    );

    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      subtitle: body,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await FlutterLocalNotificationsPlugin().show(
      1,
      title,
      body,
      notificationDetails,
    );
  }
}
