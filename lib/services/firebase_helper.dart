import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FirebaseService {




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
        // debugPrint("FCM Token: $value");
        return fcmToken;
      },
    );
  }
}
