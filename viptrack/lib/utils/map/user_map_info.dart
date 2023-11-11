// Get the current user location
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:viptrack/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/main.dart';
import 'package:viptrack/models/suggestion.dart';
import 'package:viptrack/services/maps_service.dart';
import 'package:viptrack/services/request/request_get.dart';

class UserMapInfo {
  getUserInfosForMap() async {
    SharedPref sharedPref = SharedPref();

    Position? userCurrentPosition;
    Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition = cPosition;

    LatLng currentLocation = LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);
    sharedPref.setUserLocation(currentLocation);

    // Get the current user address
    String currentAddress = await MapServices.searchAddressGeoCoord(currentLocation);
    sharedPreferences.setString('current-address', currentAddress);
  }

  static Future<List> findPlaceAutoCompleteSearch(String inputText) async {
    List autoCompleteReturn = [];
    if (inputText.length > 1) {
      autoCompleteReturn = await MapServices.findPlaceAutoComplete(inputText);
    }
    return autoCompleteReturn;
  }
}
