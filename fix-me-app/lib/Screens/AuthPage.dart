import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_me_app/Screens/MapScreen.dart';
import 'package:flutter/material.dart';
import 'package:fix_me_app/Screens/LoginScreen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MapScreen();
              } else {
                return Login();
              }
            }));
  }
}
