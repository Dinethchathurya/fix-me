import 'package:fix_me_app/Services/GetCurrentLocationForUserMap1.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'GoogleMapComponent.dart';

class FutureBuilderForGoogleMapSingleLocationForUserMap1
    extends StatelessWidget {
  const FutureBuilderForGoogleMapSingleLocationForUserMap1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Provider.of<GetCurrentLocationClassForUserMap1>(context, listen: false)
        .startListeningForLocationUpdatesForUserMap1();
    return Consumer<GetCurrentLocationClassForUserMap1>(
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
