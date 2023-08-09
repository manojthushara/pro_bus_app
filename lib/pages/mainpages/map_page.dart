
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Completer<GoogleMapController> _controller = Completer();

  //camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng( 7.874096999999999, 80.76709749999998),
    zoom: 8,
  );

  //map location maker
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng( 0, 0),
        infoWindow: InfoWindow(
          title: 'My Position',
        )
    ),
  ];

  //current user location method
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF937047),
        title: Text('Google Map'),
      ),
      body: Container(

        child: SafeArea(

                  //google map
          child: GoogleMap(
            //  camera position
            initialCameraPosition: _kGoogle,

            //markers on the map
            markers: Set<Marker>.of(_markers),

            //map type.
            mapType: MapType.normal,

            // location enabled.
            myLocationEnabled: false,

            //compass enabled.
            compassEnabled: true,

            //  controller on map complete.
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 120.0,horizontal: 0),
        child: Column(
          children: [

            FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () async{
                getUserCurrentLocation().then((value) async {
                  print(value.latitude.toString() +" "+value.longitude.toString());

                  //add new maker
                  _markers.add(
                      Marker(
                        markerId: MarkerId("2"),
                        position: LatLng(value.latitude, value.longitude),
                        infoWindow: InfoWindow(
                          title: 'My Current Location',
                        ),
                      )
                  );

                  //new camera position
                  CameraPosition cameraPosition = new CameraPosition(
                    target: LatLng(value.latitude, value.longitude),
                    zoom: 14,
                  );

                  final GoogleMapController controller = await _controller.future;
                  controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
                  setState(() {
                  });
                });
              },

              //current location button icon
                child: Icon(Icons.my_location),
              ),
          ],
        ),
      ),
    );
  }
}
