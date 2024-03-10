import 'dart:async';

import 'package:fix_me_app/Consts%20/Consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocationClass extends ChangeNotifier {
  var currentLogUserLongitude;
  var currentLogUserLatitude;
  late double nearestMechanicLocationLongitude;
  late double nearestMechanicLocationLatitude;
  late Map<PolylineId, Polyline> polylines = {};

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
    nearestMechanicLocationLongitude = 80.024566;
    nearestMechanicLocationLatitude = 6.837218;
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polyLineCordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(currentLogUserLatitude, currentLogUserLongitude),
      PointLatLng(
          nearestMechanicLocationLatitude, nearestMechanicLocationLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polyLineCordinates;
  }

  genaratePolyLineFromPoints(List<LatLng> polyLineCordinates) async {
    PolylineId Id = PolylineId('poly');
    Polyline polyline = Polyline(
        polylineId: Id,
        color: Colors.black,
        points: polyLineCordinates,
        width: 8);

    polylines[Id] = polyline;
  }
}
