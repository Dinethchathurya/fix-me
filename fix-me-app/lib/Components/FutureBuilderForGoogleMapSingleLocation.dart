import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../Models/ModelsData.dart';
import 'GoogleMapComponent.dart';

class FutureBuilderForGoogleMapSingleLocation extends StatelessWidget {
  const FutureBuilderForGoogleMapSingleLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TaskData>(context, listen: false)
          .getLoggedUsersLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          double currentLogUserLongitude =
              Provider.of<TaskData>(context, listen: false)
                  .currentLogUserLongitude;
          double currentLogUserLatitude =
              Provider.of<TaskData>(context, listen: false)
                  .currentLogUserLatitude;

          return GoogleMapWidget(
            cameraPositionLatLng:
                LatLng(currentLogUserLatitude, currentLogUserLongitude),
            polylines: {},
            markers: <Marker>{
              Marker(
                markerId: MarkerId('Log User Location'),
                position:
                    LatLng(currentLogUserLatitude, currentLogUserLongitude),
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
