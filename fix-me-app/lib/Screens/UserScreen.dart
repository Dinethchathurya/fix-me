import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/UsersFirstMapScreen.dart';
import '../Services/GetUserCurrentLocationForFirstMap.dart';

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
        onPressed: () {
          Provider.of<GetCurrentLocationClassForFirstMapPage>(context,
                  listen: false)
              .startListeningForLocationUpdatesForFirstMapPage();
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
