import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/screens/offer_ride/screen_offer_ride_prepare.dart';
import '../main.dart';

class ScreenOffenRide extends StatefulWidget {
  const ScreenOffenRide({super.key});

  @override
  State<ScreenOffenRide> createState() => _ScreenOffenRideState();
}

class _ScreenOffenRideState extends State<ScreenOffenRide> {
  late String currentAddress = '';
  SharedPref sharedPref = SharedPref();

  LatLng? pickLocation;
  loc.Location location = loc.Location();
  String? _address;

  //Controller do map
  final Completer<GoogleMapController> _controllerGoogleMap = Completer<GoogleMapController>();
  GoogleMapController? newGoogleMapController;

  //Posicao da Camera no Map
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  double searchLocationContainerHeight = 220;
  double waitingResponsefromDriverContainerHeight = 0;
  double assignedDrivinerInfoContainerHeigth = 0;

  var geoLocation = Geolocator();

  LocationPermission? locationPermission;
  double bottomPaddingOfMap = 0;

  List<LatLng> pLineCoordinatedList = [];
  Set<Polyline> polyLineSet = {};

  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};

  String userName = "";
  String userEmail = "";

  bool openNavigationDrawer = true;
  bool activeNearByDriverKeyLoaded = false;

  BitmapDescriptor? activeNearbyIcon;

  //Pegando posicao do usuario
  locateUserPosition() async {
    LatLng latLngPosition = sharedPref.getUserLocation();
    print(latLngPosition);

    CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 15);
    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  getAddressFromLatLng() async {
    try {
      GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: pickLocation!.latitude,
        longitude: pickLocation!.longitude,
        googleMapApiKey: dotenv.env['MAP_KEY']!,
      );
      setState(() {
        _address = data.address;
      });
    } catch (e) {
      print(e);
    }
  }

  checkIfLocationPermissionAllowed() async {
    locationPermission = await Geolocator.requestPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
  }

  @override
  void initState() {
    super.initState();

    checkIfLocationPermissionAllowed();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * 0.60,
                child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    initialCameraPosition: _kGooglePlex,
                    polylines: polyLineSet,
                    markers: markerSet,
                    circles: circleSet,
                    onMapCreated: (controller) {
                      _controllerGoogleMap.complete(controller);
                      newGoogleMapController = controller;
                      setState(() {});
                      locateUserPosition();
                    },
                    onCameraMove: (position) {
                      if (pickLocation != position.target) {
                        setState(() {
                          pickLocation = position.target;
                        });
                      }
                    },
                    onCameraIdle: () {
                      getAddressFromLatLng();
                    }),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  'Eaeee!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Você está atualemente está aqui: ',
                ),
                Text(
                  sharedPref.getCurrentAddressFromSharedPrefs(),
                  style: const TextStyle(color: Colors.indigoAccent, fontSize: 15),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrepareRide())),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(14)),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Onde você quer ir?'),
                    ])),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
