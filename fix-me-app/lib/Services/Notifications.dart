import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> haddleBackgroundMessage(message) async {
    print('Title: ${message.notification?.title}');
    print('body: ${message.notification?.body}');
    print('data: ${message.notification?.data}');
  }

  Future<void> initNotifications() async {
    intt();
    final fCMToken = await _firebaseMessaging.getToken();
    print(fCMToken);
    FirebaseMessaging.onBackgroundMessage(
        (message) => haddleBackgroundMessage(haddleBackgroundMessage));
  }

  Future<void> intt() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
