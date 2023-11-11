import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geolocator/geolocator.dart';
import 'package:viptrack/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/screens/login_auth/auth_screen.dart';
import 'package:viptrack/services/maps_service.dart';
import 'package:viptrack/utils/map/user_map_info.dart';

import '../main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    initializeLocationAndSave();
  }

  void initializeLocationAndSave() async {
    SharedPref sharedPref = SharedPref();
    // Ensure all permissions are collected for Locations
    loc.Location _location = loc.Location();
    bool? _serviceEnabled;
    loc.PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    await UserMapInfo().getUserInfosForMap();

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Image.asset("assets/images/logo/viptrack.png"),
      ),
    );
  }
}
