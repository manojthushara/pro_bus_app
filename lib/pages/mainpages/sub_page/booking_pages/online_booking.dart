
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/search_buses.dart';

class OnlineBookingPage extends StatefulWidget {
  const OnlineBookingPage({Key? key}) : super(key: key);

  @override
  State<OnlineBookingPage> createState() => _OnlineBookingPagState();
}

class _OnlineBookingPagState extends State<OnlineBookingPage> {

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
      appBar: AppBar(
        backgroundColor: Color(0xFF241f1c),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                SizedBox(height: 50,),

                Center(
                  child: SizedBox(
                    height: 590.0,
                    child: Expanded(
                      child: FutureBuilder(
                        future: getUserProfilePicture(),
                        builder: (context, snapshot) {
                          return ListView.builder(
                              itemCount: docIDS.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 35,left: 35,top: 10),
                                  child: GetSearchBusesList(documentId: docIDS[index]),
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
