import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DrawPolyline {
  late Map<PolylineId, Polyline> polylines = {};
  var currentLogUserLatitude;
  var currentLogUserLongitude;
  var nearestMechanicLocationLatitude;
  var nearestMechanicLocationLongitude;
  var googleApiKey = 'AIzaSyDNwmSnZ9YxQmGDuAdFnDhp2RiF_OYAPH4';

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

  genaratePolyLineFromPoints(List<LatLng> polyLineCordinates) {
    PolylineId Id = PolylineId('poly');
    Polyline polyline = Polyline(
        polylineId: Id,
        color: Colors.black,
        points: polyLineCordinates,
        width: 8);

    polylines[Id] = polyline;
  }
}
