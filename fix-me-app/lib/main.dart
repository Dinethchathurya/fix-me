import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/ModelsData.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/MapScreen.dart';
import 'Screens/RegisterScreen.dart';
import 'Screens/testscreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'fix-me-app-d8065', // Use the correct project ID here
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
