import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:viptrack/application/helpers/commons.dart';
import 'package:viptrack/application/helpers/preferences_shared/shared_prefs.dart';
import 'package:viptrack/domain/models/direction_details_info.dart';
import 'package:viptrack/domain/models/directions.dart';
import 'package:location/location.dart' as loc;
import 'package:viptrack/widgets/review_ride_bottom_sheet.dart';

class ReviewRide extends StatefulWidget {
  final DirectionDetaislInfo directionDetails;
  final LatLng latLngSource;
  final LatLng latLngDestination;
  const ReviewRide({
    Key? key,
    required this.directionDetails,
    required this.latLngSource,
    required this.latLngDestination,
  }) : super(key: key);

  @override
  State<ReviewRide> createState() => _ReviewRideState();
}

class _ReviewRideState extends State<ReviewRide> {
  // Mapbox Maps SDK related
  final List<CameraPosition> _kTripEndPoints = [];
  late CameraPosition _initialCameraPosition;

  // Directions API response related
  String? distance;
  String? dropOffTime;

  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    initialiseDirectionsResponse();
    //drawPoliLinesRoute(false);

    super.initState();
  }

  initialiseDirectionsResponse() {
    distance = (widget.directionDetails.distance_value! / 1000).toStringAsFixed(1);
    dropOffTime = getDropOffTime(widget.directionDetails.duration_value!);
  }

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

  Future<void> drawPoliLinesRoute(bool dartTheme) async {
    //Variaveis da parte de route
    PolylinePoints pPoints = PolylinePoints();
    sharedPref.setTripDirectionDetail(widget.directionDetails);
    List<PointLatLng> decodePolyLinePoints = pPoints.decodePolyline(widget.directionDetails.e_points!);
    pLineCoordinatedList.clear();

    if (decodePolyLinePoints.isNotEmpty) {
      decodePolyLinePoints.forEach((PointLatLng pointLatLng) {
        pLineCoordinatedList.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    polyLineSet.clear();
    setState(() {
      Polyline polyline = Polyline(
        polylineId: const PolylineId('PolylineID'),
        color: dartTheme ? Colors.amberAccent : const Color.fromARGB(255, 21, 68, 150),
        jointType: JointType.round,
        points: pLineCoordinatedList,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
        width: 5,
      );

      polyLineSet.add(polyline);
    });

    LatLngBounds boundsLatLng;
    double originLat = widget.latLngSource.latitude;
    double originLong = widget.latLngSource.longitude;
    double destLat = widget.latLngDestination.latitude;
    double destLong = widget.latLngDestination.longitude;

    if (originLat > destLat && originLong > destLong) {
      boundsLatLng = LatLngBounds(
        southwest: widget.latLngDestination,
        northeast: widget.latLngSource,
      );
    } else if (originLat > destLong) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(originLat, destLong),
        northeast: LatLng(destLat, originLong),
      );
    } else if (originLat > destLat) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(destLat, originLong),
        northeast: LatLng(originLat, destLong),
      );
    } else {
      boundsLatLng = LatLngBounds(
        southwest: widget.latLngSource,
        northeast: widget.latLngDestination,
      );
    }

    newGoogleMapController!.animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 100));
    Marker originMarker = Marker(
      markerId: const MarkerId('originID'),
      position: widget.latLngSource,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    Marker destinationMarker = Marker(
      markerId: const MarkerId('destinationID'),
      position: widget.latLngDestination,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    setState(() {
      markerSet.add(originMarker);
      markerSet.add(destinationMarker);
    });

    Circle originCircle = Circle(
      circleId: const CircleId('originID'),
      fillColor: Colors.green,
      strokeColor: Colors.green,
      radius: 5,
      //strokeColor: Colors.white,
      center: widget.latLngSource,
    );

    Circle destinationCircle = Circle(
      circleId: const CircleId('destinationID'),
      fillColor: Colors.red,
      strokeColor: const Color.fromARGB(255, 150, 25, 16),
      radius: 5,

      //strokeColor: Colors.white,
      center: widget.latLngDestination,
    );

    setState(() {
      circleSet.add(originCircle);
      circleSet.add(destinationCircle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Review Ride'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
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
                    drawPoliLinesRoute(false);
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
            reviewRideBottomSheet(context, distance, dropOffTime),
          ],
        ),
      ),
    );
  }
}
