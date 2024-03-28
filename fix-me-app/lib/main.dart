import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fix_me_app/Screens/MapScreen.dart';
import 'package:fix_me_app/Services/GetTokenNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'Models/ModelsData.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/MechanicOnlineScreen.dart';
import 'Screens/PersonalDetails.dart';
import 'Screens/Rating_bottom_sheet.dart';
import 'Screens/RegisterScreen.dart';
import 'Services/GetCurrentLocation.dart';
import 'Services/GetMechanicLocation.dart';
import 'Services/GetUserCurrentLocationForFirstMap.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationClass notificationClass = NotificationClass();
  await notificationClass.getFcmTokenForNotification();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  _firebaseMessaging.requestPermission(provisional: true);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();

    _initFirebaseMessaging(context);
    _initLocalNotifications();
  }

  void _initFirebaseMessaging(context) {
    _firebaseMessaging.requestPermission(provisional: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received message: ${message.notification!.title}");

      _showNotification(message.notification!);

      // _pageRedirect(context, message);
    });
  }

  void _pageRedirect(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'msj') {
      //  Navigator.pushNamed(context, '/ClientDetails');
    }
  }

  Future<void> _initLocalNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(RemoteNotification notification) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'Fix-Me',
      'You have a client',
      importance: Importance.max,
      priority: Priority.high,
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      platformChannelSpecifics,
    );
  }

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskData>(
          create: (context) => TaskData(),
        ),
        ChangeNotifierProvider<GetCurrentLocationClass>(
          create: (context) => GetCurrentLocationClass(),
        ),
        ChangeNotifierProvider<GetCurrentLocationClassForFirstMapPage>(
          create: (context) => GetCurrentLocationClassForFirstMapPage(),
        ),
        ChangeNotifierProvider<GetMechanicLocation>(
          create: (context) => GetMechanicLocation(),
        ),
      ],
      builder: (BuildContext context, Widget) {
        return MaterialApp(
          theme: ThemeData.light(),
          initialRoute: '/',
          routes: {
            '/': (context) => Login(),
            '/register': (context) => Register(),
            '/mechanicOnlineMapScreen': (context) => MechanicOnlineScreen(),
            '/map': (context) => MapScreen(),
            '/personalDetails': (context) => PersonalDetails(),
            '/ratingScreen': (context) => RatingBottomSheet(),
          },
        );
      },
    );
  }
}
