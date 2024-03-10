import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Services/GetLocation.dart';

class TaskData extends ChangeNotifier {
  late double nearestMechanicLocationLatitude;
  late double nearestMechanicLocationLongitude;
  late double currentLogUserLatitude;
  late double currentLogUserLongitude;
  Map<PolylineId, Polyline> polylinesInTaskData = {};

  getUsersLocationData() async {
    GetLocationClass getLocationClass = GetLocationClass();
    await getLocationClass.getCurrentUserLocation();
    currentLogUserLatitude = await getLocationClass.currentLogUserLatitude;
    currentLogUserLongitude = await getLocationClass.currentLogUserLongitude;
    await getLocationClass.getMechanicLocation();
    nearestMechanicLocationLatitude =
        await getLocationClass.nearestMechanicLocationLatitude;
    nearestMechanicLocationLongitude =
        await getLocationClass.nearestMechanicLocationLongitude;

    var polyLineCordinates = await getLocationClass.getPolylinePoints();
    await getLocationClass.genaratePolyLineFromPoints(polyLineCordinates);

    polylinesInTaskData = await getLocationClass.polylines;
  }
}
