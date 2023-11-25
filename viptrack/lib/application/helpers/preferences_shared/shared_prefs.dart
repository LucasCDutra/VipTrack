import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viptrack/domain/models/user.dart';
import 'dart:convert';
import 'package:viptrack/main.dart';
import 'package:viptrack/domain/models/direction_details_info.dart';
import 'package:viptrack/domain/models/directions.dart';

class SharedPref extends GetxController {
  void setUserCurrent(UserApp user) {
    sharedPreferences.setString('uid', user.uid ?? '');
    sharedPreferences.setString('nome', user.nome ?? '');
    sharedPreferences.setString('email', user.email ?? '');
    sharedPreferences.setString('telefone', user.telefone ?? '');
  }

  UserApp getUserCurrent() {
    String? uid = sharedPreferences.getString('uid');
    String? nome = sharedPreferences.getString('nome');
    String? email = sharedPreferences.getString('email');
    String? telefone = sharedPreferences.getString('telefone');
    final userAuth = FirebaseAuth.instance;

    return UserApp(
      uid: uid,
      nome: nome,
      email: email,
      telefone: telefone,
      auth: userAuth,
    );
  }

  void setUserLocation(LatLng location) async {
    sharedPreferences.setDouble('latitude', location.latitude);
    sharedPreferences.setDouble('longitude', location.longitude);
  }

  LatLng getUserLocation() {
    return LatLng(sharedPreferences.getDouble('latitude')!, sharedPreferences.getDouble('longitude')!);
  }

  void setDirection(Directions source, {bool isSource = true}) {
    String type = isSource ? 'source' : 'destination';

    source.address != null ? sharedPreferences.setString('${type}_address', source.address!) : '';
    source.locationName != null ? sharedPreferences.setString('${type}_name', source.locationName!) : '';
    source.locationid != null ? sharedPreferences.setString('${type}_id', source.locationid!) : '';
    source.locationLatitude != null ? sharedPreferences.setDouble('${type}_latitude', source.locationLatitude!) : '';
    source.locationLongitude != null ? sharedPreferences.setDouble('${type}_longitude', source.locationLongitude!) : '';
    source.city != null ? sharedPreferences.setString('${type}_city', source.city!) : '';
  }

  Directions getUserSourceDirection({bool isSource = true}) {
    String type = isSource ? 'source' : 'destination';
    Directions source = Directions();
    source.address = sharedPreferences.getString('${type}_address');
    source.locationName = sharedPreferences.getString('${type}_name');
    source.locationid = sharedPreferences.getString('${type}_id');
    source.locationLatitude = sharedPreferences.getDouble('${type}_latitude');
    source.locationLongitude = sharedPreferences.getDouble('${type}_longitude');
    source.city = sharedPreferences.getString('${type}_city');

    return source;
  }

  LatLng getCurrentLatLngFromSharedPrefs() {
    return LatLng(sharedPreferences.getDouble('latitude')!, sharedPreferences.getDouble('longitude')!);
  }

  String getCurrentAddressFromSharedPrefs() {
    return sharedPreferences.getString('current-address')!;
  }

  LatLng getTripLatLngFromSharedPrefs(String type) {
    List sourceLocationList = json.decode(sharedPreferences.getString('source')!)['location'];
    List destinationLocationList = json.decode(sharedPreferences.getString('destination')!)['location'];
    LatLng source = LatLng(sourceLocationList[0], sourceLocationList[1]);
    LatLng destination = LatLng(destinationLocationList[0], destinationLocationList[1]);

    if (type == 'source') {
      return source;
    } else {
      return destination;
    }
  }

  String getSourceAndDestinationPlaceText(String type) {
    if (type == 'source') {
      Directions directions = getUserSourceDirection(isSource: true);
      return '${directions.locationName}';
    } else {
      Directions directions = getUserSourceDirection(isSource: false);
      return '${directions.locationName}';
    }
  }

  void setTripDirectionDetail(DirectionDetaislInfo detail) {
    detail.distance_text != null ? sharedPreferences.setString('distance_text', detail.distance_text!) : '';
    detail.distance_value != null ? sharedPreferences.setInt('distance_value', detail.distance_value!) : '';
    detail.duration_text != null ? sharedPreferences.setString('duration_text', detail.duration_text!) : '';
    detail.distance_value != null ? sharedPreferences.setInt('distance_value', detail.distance_value!) : '';
    detail.e_points != null ? sharedPreferences.setString('e_points', detail.e_points!) : '';
  }

  DirectionDetaislInfo getTripDirectionDetail() {
    DirectionDetaislInfo trip = DirectionDetaislInfo();
    trip.distance_text = sharedPreferences.getString('distance_text');
    trip.distance_value = sharedPreferences.getInt('distance_value');
    trip.duration_text = sharedPreferences.getString('duration_text');
    trip.distance_value = sharedPreferences.getInt('distance_value');
    trip.e_points = sharedPreferences.getString('e_points');

    return trip;
  }
}
