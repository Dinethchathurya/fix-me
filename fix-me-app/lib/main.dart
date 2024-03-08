import 'package:fix_me_app/Screens/MapScreen.dart';
import 'package:flutter/material.dart';

import 'Screens/LoginScreen.dart';
import 'Screens/RegisterScreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/register': (context) => Register(),
        '/map': (context) => MapScreen(),
      },
    );
  }
}
