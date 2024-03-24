import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentLocationClassForFirstMapPage extends ChangeNotifier {
  double? currentLogUserLongitude;
  double? currentLogUserLatitude;

  Position? _previousPosition;

  StreamSubscription<Position>? _positionStreamSubscription;

  void startListeningForLocationUpdatesForFirstMapPage() {
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

  void stopListeningForLocationUpdatesForFirstMapPage() {
    _positionStreamSubscription?.cancel();
  }
}
