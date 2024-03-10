import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/ModelsData.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/MapScreen.dart';
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
