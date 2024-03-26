import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/GetCurrentLocation.dart';

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
                  // try {
                  //   GetCurrentLocationClass get = GetCurrentLocationClass();
                  //   await get.getCurrentUserLocation();
                  // } catch (e) {
                  //   print(e);
                  // }
                },
                child: const Text('Get Current Location'),
              ),
            ),
            Consumer<GetCurrentLocationClass>(
              builder: (context, getLocation, child) {
                return Column(
                  children: [
                    Text('Longitude: ${getLocation.currentLogUserLongitude}'),
                    Text('Latitude: ${getLocation.currentLogUserLatitude}'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
