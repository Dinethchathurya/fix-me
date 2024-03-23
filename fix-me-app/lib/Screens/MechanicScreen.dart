import 'package:flutter/material.dart';

import '../Components/CosumerWidgetForMechanicMap1.dart';

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
        backgroundColor: Color(0xFF39ACE7),
        title: Text('Mechanic Home Screen'),
      ),
      body: Center(
        child: FutureBuilderForGoogleMapSingleLocationForMechanicMap1(),
      ),
    );
  }
}
