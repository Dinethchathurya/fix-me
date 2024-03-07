import 'package:fix_me_app/Screens/MapScreen.dart';
import 'package:flutter/material.dart';

import 'Screens/LoginScreen.dart';
import 'Screens/RegisterScreen.dart';

void main() {
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
        '/login': (context) => Login(),
        '/': (context) => Register(),
        '/map': (context) => MapScreen(),
      },
    );
  }
}
