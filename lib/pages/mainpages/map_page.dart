import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  LatLng? pickLocation;
  loc.Location location = loc.Location();
  String? _address;

  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  double searchLocationContainerHeight = 220;
  double watingResponsefromDriveContainerHeight = 0;
  double assignedDriverInfoContainerHeight = 0;

  Position? userCurrentPosition;
  var geoLocation = Geolocator();

  LocationPermission? _locationPermission;
  double bottonPaddingOfMap =0;

  List<LatLng> pLineCoordinatedList = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  String username = "";
  String userEmail = "";

  bool openNavigationDrawer = true;

  bool activeNearbyDriveKeysLoaded = false;

  BitmapDescriptor? activeNearbyIcon;

  locateUserPosition() async {
  Position cPostion = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  userCurrentPosition = cPostion;

  LatLng latLngPostion = LatLng(userCurrentPosition!.latitude, userCurrentPosition!.latitude);
  CameraPosition cameraPosition = CameraPosition(target: latLngPostion, zoom: 15);

  newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));


  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                initialCameraPosition: _kGooglePlex,
                polylines: polylineSet,
                markers: markersSet,
                circles: circlesSet,
                onMapCreated: (GoogleMapController controller){
                  _controllerGoogleMap.complete(controller);
                  newGoogleMapController = controller;

                  setState(() {

                  });
                  locateUserPosition();
                },
              onCameraMove: (CameraPosition? position){
                  if(pickLocation != position!.target){
                    setState(() {
                      pickLocation = position.target;
                    });
                  }
              },
              onCameraIdle: () {
                  //getAddressFormLatLng();
              },
            ),
          ],
        ),
      ),
    );
  }
}