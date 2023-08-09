import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/view_bus_profile.dart';


class Getbusview extends StatelessWidget {
  final String documentId;

  Getbusview({required this.documentId});

  @override
  Widget build(BuildContext context) {

    CollectionReference buses = FirebaseFirestore.instance.collection('buses');

    return FutureBuilder<DocumentSnapshot>(
      future: buses.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: Colors.black12,
                  ),
                  height: 145,
                  child: Column(
                    children: [
                      Row(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top: 10,left: 10),
                            child: Image.asset('lib/images/online_bus_01.png',width: 90,height: 90,),
                          ),

                          SizedBox(width: 15,),

                          Column(
                            children: [

                              //bus location
                              Padding(
                                padding: const EdgeInsets.only(top: 0,bottom: 5),
                                child: Text('${data['start_location']} to ${data['end_location']}',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),),
                              ),

                              //Bus Number
                              Text('${data['bus_no']}'),

                              //bus time
                              Padding(
                                padding: const EdgeInsets.only(top: 5,bottom: 0),
                                child: Text('${data['start_time']}  ${data['end_time']}',style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //bus list 3 button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Profile Bus Button
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewBusProfilePage(documnetID: documentId,)),
                              );
                            },
                            child: Container(
                              height: 35,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: Color(0xFF937047),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text('View',style: TextStyle
                                  (color: Colors.white,fontWeight: FontWeight.bold),
                                )
                                ),
                              ),
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              ),

              //check Online Status
              Expanded(
                child: FutureBuilder(
                    future: buses.doc(documentId).get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return '${data['bus_location_status']}' == 'Online'
                            ? Positioned(
                          bottom: 115,
                          right: 10,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 0,
                                    color: Colors.black12
                                ),
                                color: Colors.lightGreenAccent
                            ),
                          ),

                        )
                            : Positioned(
                          bottom: 115,
                          right: 10,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 0,
                                    color: Colors.black12
                                ),
                                color: Colors.grey
                            ),
                          ),

                        );
                      }
                      return Positioned(
                        bottom: 115,
                        right: 10,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 0,
                                  color: Colors.black12
                              ),
                              color: Colors.white12
                          ),
                        ),

                      );
                    }),
              ),
            ],
          );
        }
        //Loading
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            color: Colors.black12,
          ),
          height: 145,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      ),
    );
  }
}
