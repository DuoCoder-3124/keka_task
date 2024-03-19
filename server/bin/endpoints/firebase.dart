part of '../server.dart';

Future<void> _sendNotification(
  String fcmToken, {
  required String title,
  required String body,
}) async {
  final messaging = Messaging(admin!);
  await messaging.send(
    TokenMessage(
      token: fcmToken,
      notification: Notification(
        title: title,
        body: body,
      ),
    ),
  );
}
