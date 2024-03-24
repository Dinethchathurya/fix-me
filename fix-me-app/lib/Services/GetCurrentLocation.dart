import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_me_app/Services/Notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentLocationClass extends ChangeNotifier {
  double? currentLogUserLongitude;
  double? currentLogUserLatitude;

  Position? _previousPosition;

  StreamSubscription<Position>? _positionStreamSubscription;

  final _databaseReference = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  void startListeningForLocationUpdates() {
    _positionStreamSubscription = Geolocator.getPositionStream().listen(
      (Position position) {
        if (_previousPosition != null) {
          // Calculate the distance between the current and previous positions
          double distanceInMeters = Geolocator.distanceBetween(
            _previousPosition!.latitude,
            _previousPosition!.longitude,
            position.latitude,
            position.longitude,
          );

          // Only update if the distance is significant (e.g., user moved more than 10 meters)
          if (distanceInMeters > 10) {
            currentLogUserLongitude = position.longitude;
            currentLogUserLatitude = position.latitude;

            // Update the database with the new location
            _updateDatabaseWithLocation(position.latitude, position.longitude);

            // Update the previous position
            _previousPosition = position;

            notifyListeners();
          }
        } else {
          // First time receiving location, set the previous position
          _previousPosition = position;

          currentLogUserLongitude = position.longitude;
          currentLogUserLatitude = position.latitude;

          // Check if the user's location exists in the database
          _checkAndAddUserLocation(position.latitude, position.longitude);

          // Update the database with the initial location
          _updateDatabaseWithLocation(position.latitude, position.longitude);

          notifyListeners();
        }
      },
    );
  }

  void _checkAndAddUserLocation(double latitude, double longitude) async {
    try {
      // Check if the user's location document exists in the 'user_location' collection
      DocumentSnapshot snapshot = await _databaseReference
          .collection('available_mechanic_location')
          .doc('${auth.currentUser?.uid}')
          .get();

      if (!snapshot.exists) {
        // If user_location document does not exist, add the user's location to the database
        _updateDatabaseWithLocation(latitude, longitude);
      }
    } catch (e) {
      print('Error checking user location: $e');
    }
  }

  void _updateDatabaseWithLocation(double latitude, double longitude) async {
    NotificationClass notificationClass = NotificationClass();

    _databaseReference
        .collection('available_mechanic_location')
        .doc('${auth.currentUser?.uid}')
        .set({
      'latitude': latitude,
      'longitude': longitude,
      'cfm token': await notificationClass.getFcmTokenForNotification(),
      'email': auth.currentUser?.email,
    });
  }

  void stopListeningForLocationUpdates() {
    _positionStreamSubscription?.cancel();
  }
}
