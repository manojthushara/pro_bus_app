
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/search_buses.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/home_button/view_bus_list.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/home_button/view_map_bus_list.dart';

class HomeMapButton extends StatefulWidget {
  const HomeMapButton({Key? key}) : super(key: key);

  @override
  State<HomeMapButton> createState() => _HomeMapButtonState();
}

class _HomeMapButtonState extends State<HomeMapButton> {
  String searchValue = '';
  final List<String> _suggestions =
  ['Panadura - Kandy', 'Kandy - Colombo', 'Kandy - Anuradhapura', 'Kandy - Jaffna', 'Kandy - Kuruunagala',
    'Kandy - Galle', 'Kandy - Hambanthota', 'Kandy - Nuwaraeliya', 'Kandy - Badulla', 'Kandy - Madakalapuwa'];

  List<String> buses = [];
  //get Buses
  Future getBuses() async {
    await FirebaseFirestore.instance.collection('passengers').where('bus_root', isEqualTo: _suggestions).get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        buses.add(document.reference.id);
        print('Match');
      }),
    );
  }

  String getbusroot = " ";
  String getname = " ";
  final user = FirebaseAuth.instance.currentUser!;
  String getstatus = " ";

  final List<String> docIDS = [];

  Future getUserProfilePicture() async {
    await FirebaseFirestore.instance.collection('buses').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        docIDS.add(document.reference.id);
      }
      ),
    );
  }
  //get firebase details
  Future getBusStatus() async {
    await FirebaseFirestore.instance.collection('buses').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        setState(() async {
          getstatus = '${document['bus_location_status']}';

        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFFe7dac7),
      appBar: EasySearchBar(
          title: const Text('Home',style: TextStyle(
            color: Colors.white,
          ),),
          backgroundColor: Color(0xFF937047),
          onSearch: (value) => setState(() => searchValue = value),
          suggestions: _suggestions,
          iconTheme: IconThemeData(color: Colors.white)
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Center(
                  child: SizedBox(
                    height: 650.0,
                    child: Expanded(
                      child: FutureBuilder(
                        future: getUserProfilePicture(),
                        builder: (context, snapshot) {
                          return ListView.builder(
                              itemCount: docIDS.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 35,left: 35,top: 10),
                                  child: GetMapview(documentId: docIDS[index]),
                                );
                              });
                        },
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
