import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Components/FutureBuilderForGoogleMapSingleLocation.dart';

class MechanicOnlineScreen extends StatefulWidget {
  const MechanicOnlineScreen({super.key});

  @override
  State<MechanicOnlineScreen> createState() => _MechanicScreenState();
}

class _MechanicScreenState extends State<MechanicOnlineScreen> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(' ${_auth.currentUser?.email}'),
        backgroundColor: const Color(0xFF39ACE7),
      ),
      body: Center(
        child: GoogleMapForMechanicOnlineScreenLocation(),
      ),
    );
  }
}
