import 'package:fix_me_app/Screens/MapScreen.dart';
import 'package:flutter/material.dart';

import 'Screens/LoginScreen.dart';
import 'Screens/RegisterScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      initialRoute: '/map',
      routes: {
        '/': (context) => Login(),
        '/register': (context) => Register(),
        '/map': (context) => MapScreen(),
      },
    );
  }
}
