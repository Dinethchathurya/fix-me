import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget(
      {super.key,
      required this.polylines,
      required this.markers,
      required this.cameraPositionLatLng});

  final Map<PolylineId, Polyline> polylines;
  final Set<Marker> markers;
  final LatLng cameraPositionLatLng;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: cameraPositionLatLng,
        zoom: 16.0,
      ),
      markers: markers,
      polylines: Set<Polyline>.of(polylines.values),
    );
  }
}
