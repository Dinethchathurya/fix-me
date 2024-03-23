import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fix_me_app/Services/Notifications.dart';
import 'package:flutter/material.dart';

class TestFirebase extends StatelessWidget {
  const TestFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: TextButton(
                onPressed: () async {
                  FirebaseNotification firebase = FirebaseNotification();
                  firebase.initNotifications();
                },
                child: const Text('Get Current Location'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
