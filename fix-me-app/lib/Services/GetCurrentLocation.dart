import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentLocationClass extends ChangeNotifier {
  var currentLogUserLongitude;
  var currentLogUserLatitude;

  StreamSubscription<Position>? _positionStreamSubscription;

  void startListeningForLocationUpdates() {
    _positionStreamSubscription = Geolocator.getPositionStream().listen(
      (Position position) {
        currentLogUserLongitude = position.longitude;
        currentLogUserLatitude = position.latitude;
        notifyListeners();
      },
    );
  }

  void stopListeningForLocationUpdates() {
    _positionStreamSubscription?.cancel();
  }
}
