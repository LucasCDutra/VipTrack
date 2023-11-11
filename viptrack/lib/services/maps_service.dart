import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:viptrack/models/directions.dart';
import 'package:viptrack/models/predicted_places.dart';
import 'package:viptrack/models/suggestion.dart';
import 'package:viptrack/services/request/request_get.dart';

class MapServices {
  static Future<String> searchAddressGeoCoord(LatLng position) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${dotenv.env['MAP_KEY']}";
    String currentAddress = "";
    var requestResponse = await RequestGet.requestWithUrl(apiUrl);

    if (requestResponse != "Error Occured. Failed. No Response.") {
      currentAddress = requestResponse["results"][0]["formatted_address"];

      Directions userPickUpAddress = Directions(
        address: currentAddress,
        locationLatitude: position.latitude,
        locationLongitude: position.longitude,
      );
    }
    return currentAddress;
  }

  static Future<List> findPlaceAutoComplete(String inputText) async {
    String urlAutoCompleteSearch =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=${dotenv.env["MAP_KEY"]}&components=country:BR';

    var responseAutoCompleteSearch = await RequestGet.requestWithUrl(urlAutoCompleteSearch);
    List placePredicitionsList = [];
    if (responseAutoCompleteSearch['status'] == 'OK') {
      var placePredicitions = responseAutoCompleteSearch['predictions'];
      placePredicitionsList =
          (placePredicitions as List).map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();
    }
    return placePredicitionsList;
  }
}
