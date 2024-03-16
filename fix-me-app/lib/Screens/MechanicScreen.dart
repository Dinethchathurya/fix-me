import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MechanicScreen extends StatefulWidget {
  const MechanicScreen({super.key});

  @override
  State<MechanicScreen> createState() => _MechanicScreenState();
}

class _MechanicScreenState extends State<MechanicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Mechanic",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Center(
        child: Text("Mechanic page"),
      ),
    );
  }
}
