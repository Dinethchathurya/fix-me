import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationClass extends ChangeNotifier {
  var currentLogUserLongitude;
  var currentLogUserLatitude;
  late double nearestMechanicLocationLongitude;
  late double nearestMechanicLocationLatitude;

  getCurrentUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show a dialog to enable them
      bool enableResult = await Geolocator.openLocationSettings();
      if (!enableResult) {
        // The user did not enable location services, handle accordingly
        print('User did not enable location services');
        return;
      }
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions were denied, handle accordingly
      print('Location permissions denied');
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );
    currentLogUserLongitude = position.longitude;
    currentLogUserLatitude = position.latitude;
  }

  getMechanicLocation() {
    nearestMechanicLocationLongitude = 80.023566;
    nearestMechanicLocationLatitude = 6.838218;
  }
}
