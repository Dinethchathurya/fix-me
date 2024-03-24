import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/UsersFirstMapScreen.dart';
import '../Services/GetUserCurrentLocationForFirstMap.dart';

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
        onPressed: () {
          Provider.of<GetCurrentLocationClassForFirstMapPage>(context,
                  listen: false)
              .startListeningForLocationUpdatesForFirstMapPage();
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
