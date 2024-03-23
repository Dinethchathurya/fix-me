import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fix_me_app/Services/Notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/ModelsData.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/MapScreen.dart';
import 'Screens/RegisterScreen.dart';
import 'Screens/testscreen.dart';
import 'Services/GetCurrentLocationAndUpdateDatabase.dart';
import 'Services/GetCurrentLocationForUserMap1.dart';
import 'firebase_options.dart';

Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('some notification came');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotification().intt();
  FirebaseMessaging.onBackgroundMessage(
      (message) => _firebaseBackgroundMessage(message));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskData>(
          create: (context) => TaskData(),
        ),
        ChangeNotifierProvider<GetCurrentLocationClass>(
          create: (context) => GetCurrentLocationClass(),
        ),
        ChangeNotifierProvider<GetCurrentLocationClassForUserMap1>(
          create: (context) => GetCurrentLocationClassForUserMap1(),
        ),
      ],
      builder: (BuildContext context, Widget) {
        return MaterialApp(
          theme: ThemeData.light(),
          initialRoute: '/test',
          routes: {
            '/': (context) => Login(),
            '/register': (context) => Register(),
            '/map': (context) => MapScreen(),
            '/test': (context) => TestFirebase(),
          },
        );
      },
    );
  }
}
