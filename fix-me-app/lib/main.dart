import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/ModelsData.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/MapScreen.dart';
import 'Screens/RegisterScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return TaskData();
      },
      builder: (BuildContext context, Widget) {
        return MaterialApp(
          theme: ThemeData.light(),
          initialRoute: '/map',
          routes: {
            '/': (context) => Login(),
            '/register': (context) => Register(),
            '/map': (context) => MapScreen(),
          },
        );
      },
    );
  }
}
