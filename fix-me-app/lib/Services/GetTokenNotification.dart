import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class NotificationClass {
  getFcmTokenForNotification() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();

    print(fcmToken);
    try {
      final notificationSettings =
          await FirebaseMessaging.instance.requestPermission(provisional: true);

// For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        // APNS token is available, make FCM plugin API requests...
      }

      return fcmToken;
    } catch (e) {
      print('case :$e');
    }
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    //
  }
}
