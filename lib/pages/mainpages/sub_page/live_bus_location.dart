
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveBusLocationPage extends StatefulWidget {
  String documnetID;
  LiveBusLocationPage ({required this.documnetID,});

  @override
  State<LiveBusLocationPage> createState() => _LiveBusLocationPageState();
}
final user = FirebaseAuth.instance.currentUser!;

class _LiveBusLocationPageState extends State<LiveBusLocationPage> {
  late GoogleMapController mapController;
  GeoPoint? geoPoint;

  @override
  void initState() {
    super.initState();
    fetchGeoPoint();
  }

  Future<void> fetchGeoPoint() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance
        .collection('buses')
        .doc(widget.documnetID)
        .get();
    if (documentSnapshot.exists) {
      setState(() {
        geoPoint = documentSnapshot.data()!['location'] as GeoPoint?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Bus List'),
        backgroundColor: Color(0xFF937047),
      ),
      body: geoPoint != null
          ? GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(geoPoint!.latitude, geoPoint!.longitude),
          zoom: 14.0,
        ),
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        markers: Set<Marker>.from([
          Marker(
            markerId: MarkerId('location'),
            position: LatLng(geoPoint!.latitude, geoPoint!.longitude),
          ),
        ]),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
