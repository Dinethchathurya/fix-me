import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../Services/GetCurrentLocation.dart';
import 'GoogleMapComponent.dart';

class FutureBuilderForGoogleMapSingleLocation extends StatelessWidget {
  const FutureBuilderForGoogleMapSingleLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Provider.of<GetCurrentLocationClass>(context, listen: false)
        .startListeningForLocationUpdates();

    return Consumer<GetCurrentLocationClass>(
      builder: (context, locationData, _) {
        if (locationData.currentLogUserLongitude != null &&
            locationData.currentLogUserLatitude != null) {
          return GoogleMapWidget(
            cameraPositionLatLng: LatLng(
              locationData.currentLogUserLatitude ?? 0.0,
              locationData.currentLogUserLongitude ?? 0.0,
            ),
            polylines: {},
            markers: <Marker>{
              Marker(
                markerId: MarkerId('Log User Location'),
                position: LatLng(
                  locationData.currentLogUserLatitude ?? 0.0,
                  locationData.currentLogUserLongitude ?? 0.0,
                ),
              ),
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
