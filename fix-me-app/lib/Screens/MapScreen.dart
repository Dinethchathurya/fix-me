import 'package:fix_me_app/Services/GetLocation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    // GetLocationClass getLocationClass = GetLocationClass();
    // getLocationClass.GetLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Google(),
        //TODO crete map page here
      ),
    );
  }
}

class Google extends StatefulWidget {
  @override
  State<Google> createState() => _GooleState();
}

class _GooleState extends State<Google> {
  @override
  void initState() {
    super.initState();
    getlatlng();
  }

  double? lat;
  double? lon;
  var isLoading = true;

  void getlatlng() async {
    GetLocationClass getLocationClass = GetLocationClass();
    await getLocationClass.GetLocation();
    setState(() {
      lat = getLocationClass.lat;
      lon = getLocationClass.log;
      isLoading = false; // Set isLoading to false once data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator(); // or any other loading indicator
    }

    return Center(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(lat!, lon!),
          zoom: 16.5,
        ),
        markers: {
          Marker(
            markerId: MarkerId('Sydney'),
            position: LatLng(lat!, lon!),
          ),
          Marker(
            markerId: MarkerId('Sydne'),
            position: LatLng(6.839118, 80.021366),
          ),
        },
      ),
    );
  }
}
