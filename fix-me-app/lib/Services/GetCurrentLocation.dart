import 'package:geolocator/geolocator.dart';

class GetCurrentLocationClass {
  var currentLogUserLongitude;
  var currentLogUserLatitude;

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
      // get users current location using geolocator package.
      desiredAccuracy: LocationAccuracy.medium,
      // we use accuracy level medium because downgrade battery usage.
    );
    currentLogUserLongitude = position.longitude;
    currentLogUserLatitude = position.latitude;
  }
}
