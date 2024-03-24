import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../Services/GetUserCurrentLocationForFirstMap.dart';
import 'GoogleMapComponent.dart';

class UsersFirstMapScreen extends StatelessWidget {
  const UsersFirstMapScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Provider.of<GetCurrentLocationClassForFirstMapPage>(context, listen: false)
        .startListeningForLocationUpdatesForFirstMapPage();

    return Consumer<GetCurrentLocationClassForFirstMapPage>(
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
