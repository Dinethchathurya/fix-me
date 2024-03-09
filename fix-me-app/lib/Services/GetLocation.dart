import 'package:geolocator/geolocator.dart';

class GetLocationClass {
  var log;
  var lat;

  GetLocation() async {
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
    log = position.longitude;
    lat = position.latitude;
  }
}
