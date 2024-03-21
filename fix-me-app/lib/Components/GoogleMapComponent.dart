import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget(
      {super.key,
      required this.polylines,
      required this.markers,
      required this.cameraPositionLatLng});

  final Map<PolylineId, Polyline> polylines;
  final Set<Marker> markers;
  final LatLng cameraPositionLatLng;

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.cameraPositionLatLng,
        zoom: 15,
      ),
      onMapCreated: (controller) {
        _mapController = controller;
      },
      markers: widget.markers,
      polylines: Set<Polyline>.of(widget.polylines.values),
    );
  }

  void updateCameraPosition(LatLng newPosition) {
    _mapController.animateCamera(CameraUpdate.newLatLng(newPosition));
  }
}
