import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geolocator/geolocator.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/screens/login_auth/auth_screen.dart';
import 'package:viptrack/utils/map/user_map_info.dart';

import '../../main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat();
  late final Animation<double> _scaleAnimation = Tween<double>(begin: 0.6, end: 1.2).animate(_controller);
  late final Animation<double> _fadeAnimation = Tween<double>(begin: 1, end: 0.2).animate(_controller);

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 80 * 1.5,
                  height: 80 * 1.5,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 155, 155, 155)),
                ),
              ),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/logo/viptrack_circle.png",
              scale: 4,
            ),
          ),
        ],
      ),
    );
  }
}
