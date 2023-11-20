import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:viptrack/domain/models/direction_details_info.dart';
import 'package:viptrack/domain/models/directions.dart';
import 'package:viptrack/domain/models/predicted_places.dart';
import 'package:viptrack/domain/models/suggestion.dart';
import 'package:viptrack/domain/services/request/request_get.dart';

class MapServices {
  static Future<Directions> searchAddressGeoCoord(LatLng position) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${dotenv.env['MAP_KEY']}";
    String currentAddress = "";
    var requestResponse = await RequestGet.requestWithUrl(apiUrl);

    Directions userPickUpAddress = Directions();

    if (requestResponse != "Error Occured. Failed. No Response.") {
      currentAddress = requestResponse["results"][0]["formatted_address"];

      userPickUpAddress = Directions(
        address: currentAddress,
        locationLatitude: position.latitude,
        locationLongitude: position.longitude,
      );
    }
    return userPickUpAddress;
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

  static Future<Directions> getPlaceDiretionsDetails(String placeId) async {
    String urlAutoCompleteSearch =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${dotenv.env["MAP_KEY"]}';

    var response = await RequestGet.requestWithUrl(urlAutoCompleteSearch);
    Directions directions = Directions();
    if (response['status'] == 'OK') {
      directions.address = response['result']['formatted_address'];
      directions.locationName = response['result']['address_components'][0]['short_name'];
      directions.locationid = response['result']['place_id'];
      directions.locationLatitude = response['result']['geometry']['location']['lat'];
      directions.locationLongitude = response['result']['geometry']['location']['lng'];
    }
    return directions;
  }

  static Future<DirectionDetaislInfo> obtainOriginToDestination(
      LatLng originPosition, LatLng destinationPosition) async {
    String urlOriginToDestination =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${originPosition.latitude},${originPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=${dotenv.env["MAP_KEY"]}';

    var response = await RequestGet.requestWithUrl(urlOriginToDestination);

    //if (response == "Error Occured. Failed. No Response") return null;

    DirectionDetaislInfo directionDetaislInfo = DirectionDetaislInfo();
    directionDetaislInfo.e_points = response['routes'][0]['overview_polyline']['points'];

    directionDetaislInfo.distance_text = response['routes'][0]['legs'][0]['distance']['text'];
    directionDetaislInfo.distance_value = response['routes'][0]['legs'][0]['distance']['value'];

    directionDetaislInfo.duration_text = response['routes'][0]['legs'][0]['duration']['text'];
    directionDetaislInfo.duration_value = response['routes'][0]['legs'][0]['duration']['value'];

    return directionDetaislInfo;
  }
}
