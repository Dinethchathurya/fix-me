import 'package:fix_me_app/Services/GetMechanicLocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Services/GetCurrentLocation.dart';

class TaskData extends ChangeNotifier {
  late double nearestMechanicLocationLatitude;
  late double nearestMechanicLocationLongitude;
  late double currentLogUserLatitude;
  late double currentLogUserLongitude;
  Map<PolylineId, Polyline> polylinesInTaskData = {};

  getUsersLocationData() async {
    GetCurrentLocationClass getLocationClass = GetCurrentLocationClass();
    await getLocationClass.getCurrentUserLocation();
    currentLogUserLatitude = await getLocationClass.currentLogUserLatitude;
    currentLogUserLongitude = await getLocationClass.currentLogUserLongitude;

    GetMechanicLocation getMechanicLocation = GetMechanicLocation();
    await getMechanicLocation.getMechanicLocationMethod();
    nearestMechanicLocationLatitude =
        await getMechanicLocation.nearestMechanicLocationLatitude;
    nearestMechanicLocationLongitude =
        await getMechanicLocation.nearestMechanicLocationLongitude;

    // var polyLineCordinates = await getLocationClass.getPolylinePoints();
    // await getLocationClass.genaratePolyLineFromPoints(polyLineCordinates);
    //
    // polylinesInTaskData = await getLocationClass.polylines;
  }

  getLoggedUsersLocation() async {
    // this method for current user map screen only
    GetCurrentLocationClass getLocationClass = GetCurrentLocationClass();
    await getLocationClass.getCurrentUserLocation();

    currentLogUserLatitude = await getLocationClass.currentLogUserLatitude;
    currentLogUserLongitude = await getLocationClass.currentLogUserLongitude;
  }
}
