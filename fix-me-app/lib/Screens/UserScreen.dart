import 'package:flutter/material.dart';

import '../Components/FutureBuilderForGoogleMapSingleLocation.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home Screen'),
        backgroundColor: Color(0xFF39ACE7),
      ),
      body: Center(
        child: FutureBuilderForGoogleMapSingleLocation(),
      ),
    );
  }
}
