import 'package:firebase_core/firebase_core.dart';
import 'package:fix_me_app/Services/Notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Components/FutureBuilderForGoogleMapSingleLocation.dart';
import 'Models/ModelsData.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/MapScreen.dart';
import 'Screens/RegisterScreen.dart';
import 'Services/GetCurrentLocation.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // name: 'fix-me-app-d8065',
  );
  NotificationClass notificationClass = NotificationClass();
  await notificationClass.getFcmTokenForNotification();

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
      ],
      builder: (BuildContext context, Widget) {
        return MaterialApp(
          theme: ThemeData.light(),
          initialRoute: '/',
          routes: {
            '/': (context) => Login(),
            '/register': (context) => Register(),
            '/map': (context) => MapScreen(),
            '/test': (context) => FutureBuilderForGoogleMapSingleLocation(),
          },
        );
      },
    );
  }
}
