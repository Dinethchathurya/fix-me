import 'package:flutter/cupertino.dart';

import '../Services/GetLocation.dart';

class TaskData extends ChangeNotifier {
  late double nearestMechanicLocationLatitude;
  late double nearestMechanicLocationLongitude;
  late double currentLogUserLatitude;
  late double currentLogUserLongitude;

  getdata() async {
    GetLocationClass getLocationClass = GetLocationClass();
    await getLocationClass.getCurrentUserLocation();
    currentLogUserLatitude = await getLocationClass.currentLogUserLatitude;
    currentLogUserLongitude = await getLocationClass.currentLogUserLongitude;
    await getLocationClass.getMechanicLocation();
    nearestMechanicLocationLatitude =
        await getLocationClass.nearestMechanicLocationLatitude;
    nearestMechanicLocationLongitude =
        await getLocationClass.nearestMechanicLocationLongitude;
  }
}
