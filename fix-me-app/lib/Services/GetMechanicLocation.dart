import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class GetMechanicLocation {
  late double nearestMechanicLocationLongitude;
  late double nearestMechanicLocationLatitude;
  var indexOfLowestDistance = 0;

  List<dynamic> originAddresses = [];
  List<dynamic> destinationAddresses = [];
  List<dynamic> destinations = [];

  List<double> usersLocation = [37.4218883, -122.085];
  List<List<double>> mechanicLocations = [];
  List<String> duration = [];

  List<String> token = [];

  getMechanicLocationsFromFirebase() async {
    // Get locations from the Firestore database.
    final db = FirebaseFirestore.instance;
    try {
      await db.collection("available_mechanic_location").get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            // Extract latitude and longitude from each document
            double latitude = docSnapshot.data()['latitude'];
            double longitude = docSnapshot.data()['longitude'];

            token.add(docSnapshot.data()['cfm token']);
            // add items to token list
            mechanicLocations.add([latitude, longitude]);
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  String buildDistanceMatrixApiUrl() {
    List<double> origins = usersLocation;

    List<List<double>> destinations = mechanicLocations;

    String apiKey = 'AIzaSyDNwmSnZ9YxQmGDuAdFnDhp2RiF_OYAPH4';
    String url = buildDistanceMatrixUrl(origins, destinations, apiKey);

    return url;
  }

  String buildDistanceMatrixUrl(
      List<double> origins, List<List<double>> destinations, String apiKey) {
    String originsParam = 'origins=${origins[0]},${origins[1]}';

    String destinationsParam = 'destinations=';
    for (int i = 0; i < destinations.length; i++) {
      destinationsParam += '${destinations[i][0]},${destinations[i][1]}';
      if (i < destinations.length - 1) destinationsParam += '|';
    }
    return 'https://maps.googleapis.com/maps/api/distancematrix/json?$originsParam&$destinationsParam&units=imperial&key=$apiKey';
  }

  Future<void> callDistanceMatrixApi(String distanceMatrixUrl) async {
    try {
      // Make the HTTP GET request
      http.Response response = await http.get(Uri.parse(distanceMatrixUrl));

      // Check if the request was successful (status code 200).
      if (response.statusCode == 200) {
        // You can handle the response data here.
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        originAddresses = jsonDecode(response.body)['origin_addresses'];
        destinationAddresses =
            jsonDecode(response.body)['destination_addresses'];

        getNearestMechanicLocation(apiResponse);
      } else {
        // Handle error response.
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request.
      print('Error: $e');
    }
  }

  int getNearestMechanicLocation(Map<String, dynamic> apiResponse) {
    // find out nearest mechanic form response.
    // To get count of elements.
    List<dynamic> elements = apiResponse['rows'][0]['elements'];

    for (var j = 0; j < elements.length; j++) {
      destinations
          .add(apiResponse['rows'][0]['elements'][j]['distance']['text']);
      duration.add(apiResponse['rows'][0]['elements'][j]['duration']['text']);
    }
    // to get lowest distance.
    double lowestDistance = double.infinity;

    for (var i = 0; i < destinations.length; i++) {
      String destination = destinations[i];
      // Convert to meters.
      double distanceValue = parseDistance(destination);
      if (distanceValue < lowestDistance) {
        lowestDistance = distanceValue;
        indexOfLowestDistance = i;
      }
    }

    return indexOfLowestDistance;
  }

  double parseDistance(String distanceText) {
    // Split the distance text to extract the numeric portion and the unit.
    List<String> parts = distanceText.split(' ');
    double value = double.parse(parts[0]);
    String unit = parts[1].toLowerCase();

    switch (unit) {
      case 'mi':
        return value;
      case 'ft':
        return value * 0.3048; // 1 foot = 0.3048 meters.
      default:
        return value; // Assume the distance is already in meters.
    }
  }

  void setMechanicLocationInVariable() {
    List<double> mechanicLocation = mechanicLocations[indexOfLowestDistance];
    // Assign latitude and longitude from the list to separate variables
    nearestMechanicLocationLatitude = mechanicLocation[0];
    nearestMechanicLocationLongitude = mechanicLocation[1];
  }

  getMechanicLocationMethod() async {
    // get locations form firebase database.
    await getMechanicLocationsFromFirebase();
    //create url for matrix api.
    String distanceMatrixUrl = buildDistanceMatrixApiUrl();
    //using matrix api, get locations with distance and travel times.
    await callDistanceMatrixApi(distanceMatrixUrl);
    // find out nearest mechanic form response.
    setMechanicLocationInVariable();

    print('nearest mechanic Latitude: $nearestMechanicLocationLatitude');
    print('nearest mechanic Longitude: $nearestMechanicLocationLongitude');
    print('user address$originAddresses');
    print(
        'nearest mechanic address${destinationAddresses[indexOfLowestDistance]}');
    print(duration[indexOfLowestDistance]);
    print('mechanics token ${token[indexOfLowestDistance]}');
  }
}
