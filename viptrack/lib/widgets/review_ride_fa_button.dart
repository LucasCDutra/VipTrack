import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/domain/services/maps_service.dart';
import 'package:viptrack/domain/models/direction_details_info.dart';
import 'package:viptrack/domain/models/directions.dart';
import 'package:viptrack/screens/offer_ride/screen_offer_ride_review.dart';

Widget reviewRideFaButton(BuildContext context) {
  SharedPref sharedPref = SharedPref();
  late LatLng latlngSource;
  late LatLng latlngDestination;

  Future<DirectionDetaislInfo> _getDetailsForRoutes() async {
    Directions source = sharedPref.getUserSourceDirection(isSource: true);
    Directions destination = sharedPref.getUserSourceDirection(isSource: false);

    latlngSource = LatLng(source.locationLatitude!, source.locationLongitude!);
    latlngDestination = LatLng(destination.locationLatitude!, destination.locationLongitude!);
    DirectionDetaislInfo diretionsDetails = DirectionDetaislInfo();
    diretionsDetails = await MapServices.obtainOriginToDestination(latlngSource!, latlngDestination!);
    return diretionsDetails;
  }

  return FloatingActionButton.extended(
      icon: const Icon(Icons.local_taxi),
      onPressed: () async {
        DirectionDetaislInfo directionsDetails = await _getDetailsForRoutes();
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ReviewRide(
                      directionDetails: directionsDetails,
                      latLngSource: latlngSource,
                      latLngDestination: latlngDestination,
                    )));
      },
      label: const Text('Review Ride'));
}
