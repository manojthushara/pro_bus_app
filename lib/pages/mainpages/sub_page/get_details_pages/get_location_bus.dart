import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GetLocationBusPage extends StatefulWidget {
  const GetLocationBusPage({Key? key}) : super(key: key);

  @override
  State<GetLocationBusPage> createState() => _GetLocationBusPageState();
}

class _GetLocationBusPageState extends State<GetLocationBusPage> {

  String? _currentAddress;
  String? _current_lat;
  String? _current_lng;
  Position? _currentPosition;

  final user = FirebaseAuth.instance.currentUser!;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        _current_lat = '${_currentPosition!.latitude}';
        _current_lng = '${_currentPosition!.longitude}';
        GeoPoint geoPoint = GeoPoint(position.latitude, position.longitude);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
  @override
  void disponse() {
    _currentAddress;
    _current_lat;
    _current_lng;

    super.dispose();
  }

  //offline switch
  void offlinestuts() async {
    addStatus1Details(
      _currentAddress!,
      _current_lat!,
      _current_lng!,
    );
  }

  Future addStatus1Details(
      String address,
      String lat,
      String lng
      ) async {
    await FirebaseFirestore.instance
        .collection('buses')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
        try {
          FirebaseFirestore.instance
              .collection('buses')
              .doc(document.id)
              .update({
            'bus_location': address,
            'lat' : lat,
            'lng' : lng,


          });
          setState(() {});
        } on FirebaseAuthException catch (e) {}
      }),
    );
  }


  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng( 7.874096999999999, 80.76709749999998),
    zoom: 7,
  );


  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng( 0, 0),
        infoWindow: InfoWindow(
          title: 'My Position',
        )
    ),
  ];

  // Function to push GeoPoint value to Firestore
  void pushGeoPoint() async {
    // Get current user location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Create a GeoPoint object from the latitude and longitude
    GeoPoint geoPoint = GeoPoint(position.latitude, position.longitude);

    // Push the GeoPoint to Firestore
    await FirebaseFirestore.instance
        .collection('buses')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
            (snapshot) => snapshot.docs.forEach((document) {
      try {
        FirebaseFirestore.instance
            .collection('buses')
            .doc(document.id)
            .update({
              'location': geoPoint});

              setState(() {});

            } on FirebaseAuthException catch (e) {}
            }),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe7dac7),
      appBar: AppBar(
          backgroundColor: Color(0xFF937047),
          title: const Text("Location Page")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 400,
                child: Container(
                  child: SafeArea(

                    child: GoogleMap(

                      initialCameraPosition: _kGoogle,

                      markers: Set<Marker>.of(_markers),

                      mapType: MapType.normal,

                      myLocationEnabled: false,

                      compassEnabled: true,

                      onMapCreated: (GoogleMapController controller){
                        _controller.complete(controller);
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Text('ADDRESS : ',style:
                    TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                                ),),

              SizedBox(height: 10,),

              Container(
                height: 120,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  color: Colors.black12,
                ),
                child: Padding(
                    padding: const EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 20),
                    child: Text('${_currentAddress ?? ""}',style:
                    TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      ),
                    ),
                  ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _getCurrentPosition,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF937047),
                  minimumSize: Size(300, 50),
                ),

                child: const Text("Get Current Location",style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),),
              ),

              SizedBox(height: 20,),

              ElevatedButton(
                onPressed: pushGeoPoint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF937047),
                  minimumSize: Size(300, 50),
                ),
                child: const Text("Update Map",style: TextStyle(fontSize: 18),),
              ),

              SizedBox(height: 20,),

              ElevatedButton(
                onPressed: () {Navigator.pop(context);},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF937047),
                  minimumSize: Size(300, 50),
                ),
                child: const Text("Cancel",style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
