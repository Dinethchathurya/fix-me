import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentLocationClassForUserMap1 extends ChangeNotifier {
  double? currentLogUserLongitude;
  double? currentLogUserLatitude;
  final auth = FirebaseAuth.instance;
  Position? _previousPosition;

  StreamSubscription<Position>? _positionStreamSubscription;

  void startListeningForLocationUpdatesForUserMap1() {
    _positionStreamSubscription = Geolocator.getPositionStream().listen(
      (Position position) async {
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

            // Update the previous position
            _previousPosition = position;

            notifyListeners();
          }
        } else {
          // First time receiving location, set the previous position
          _previousPosition = position;

          currentLogUserLongitude = position.longitude;
          currentLogUserLatitude = position.latitude;

          notifyListeners();
        }
      },
    );
  }

  void stopListeningForLocationUpdatesForUserMap1() {
    _positionStreamSubscription?.cancel();
  }
}
