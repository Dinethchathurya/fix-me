import 'package:flutter/material.dart';

import '../Components/UsersFirstMapScreen.dart';

class MechanicScreen extends StatefulWidget {
  const MechanicScreen({super.key});

  @override
  State<MechanicScreen> createState() => _MechanicScreenState();
}

class _MechanicScreenState extends State<MechanicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF39ACE7),
        onPressed: () {
          // Provider.of<GetCurrentLocationClassForFirstMapPage>(context,
          //         listen: false)
          //     .stopListeningForLocationUpdatesForFirstMapPage();
          Navigator.pushNamed(context, '/mechanicOnlineMapScreen');
        },
        label: const Text('Go Online'),
      ),
      appBar: AppBar(
        title: Text('Mechanic Home'),
        backgroundColor: const Color(0xFF39ACE7),
      ),
      body: Center(
        child: UsersFirstMapScreen(),
      ),
    );
  }
}
