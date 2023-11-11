import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:viptrack/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/screens/offer_ride/screen_offer_ride_review.dart';

Widget reviewRideFaButton(BuildContext context) {
  SharedPref sharedPref = SharedPref();
  return FloatingActionButton.extended(
      icon: const Icon(Icons.local_taxi),
      onPressed: () async {
        LatLng sourceLatLng = sharedPref.getTripLatLngFromSharedPrefs('source');
        LatLng destinationLatLng = sharedPref.getTripLatLngFromSharedPrefs('destination');
        //Map modifiedResponse = await getDirectionsAPIResponse(sourceLatLng, destinationLatLng);

        // ignore: use_build_context_synchronously
        //Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewRide(modifiedResponse: modifiedResponse)));
      },
      label: const Text('Review Ride'));
}
