import 'package:fix_me_app/Services/GetMechanicLocation.dart';
import 'package:flutter/material.dart';

import '../Components/UsersFirstMapScreen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF39ACE7),
        onPressed: () {
          // Provider.of<GetCurrentLocationClassForFirstMapPage>(context,
          //         listen: false)
          //     .stopListeningForLocationUpdatesForFirstMapPage();

          GetMechanicLocation getMechanicLocation = GetMechanicLocation();
          getMechanicLocation.getMechanicLocationMethod();
        },
        label: const Text('Confirm Request '),
      ),
      appBar: AppBar(
        title: Text('User Home Screen'),
        backgroundColor: const Color(0xFF39ACE7),
      ),
      body: Center(
        child: UsersFirstMapScreen(),
      ),
    );
  }
}
