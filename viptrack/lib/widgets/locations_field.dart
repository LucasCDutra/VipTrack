import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/domain/services/maps_service.dart';
import 'package:viptrack/screens/offer_ride/screen_offer_ride_prepare.dart';
import 'package:viptrack/utils/map/user_map_info.dart';

import '../main.dart';

class LocationField extends StatefulWidget {
  final bool isDestination;
  final TextEditingController textEditingController;

  const LocationField({
    Key? key,
    required this.isDestination,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<LocationField> {
  SharedPref sharedPref = SharedPref();
  Timer? searchOnStoppedTyping;
  String query = '';

  _onChangeHandler(value) {
    // Set isLoading = true in parent
    PrepareRide.of(context)?.isLoading = true;
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping?.cancel());
    }
    setState(() => searchOnStoppedTyping = Timer(const Duration(seconds: 1), () => _searchHandler(value)));
  }

  _searchHandler(String value) async {
    List response = await UserMapInfo.findPlaceAutoCompleteSearch(value);

    PrepareRide.of(context)?.responsesState = response;
    PrepareRide.of(context)?.isResponseForDestinationState = widget.isDestination;
    setState(() => query = value);
  }

  _useCurrentLocationButtonHandler() async {
    if (!widget.isDestination) {
      LatLng currentLocation = sharedPref.getCurrentLatLngFromSharedPrefs();
      var response = await MapServices.searchAddressGeoCoord(currentLocation);

      // sharedPreferences.setString('source', response);
      sharedPref.setDirection(response, isSource: !widget.isDestination);
      widget.textEditingController.text = '${response.address}';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _useCurrentLocationButtonHandler();
  }

  @override
  Widget build(BuildContext context) {
    String placeholderText = widget.isDestination ? 'Para onde?' : 'De onde?';
    IconData? iconData = !widget.isDestination ? Icons.my_location : null;
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
      child: CupertinoTextField(
          controller: widget.textEditingController,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          placeholder: placeholderText,
          //placeholderStyle: GoogleFonts.rubik(color: Colors.indigo[300]),
          decoration: BoxDecoration(
            color: Colors.indigo[100],
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          onChanged: _onChangeHandler,
          suffix: IconButton(
              onPressed: () => _useCurrentLocationButtonHandler(),
              padding: const EdgeInsets.all(10),
              constraints: const BoxConstraints(),
              icon: Icon(iconData, size: 16))),
    );
  }
}
