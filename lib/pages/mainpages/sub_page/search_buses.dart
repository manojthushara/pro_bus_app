import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/live_bus_location.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/booking_pages/bus_sheet.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/view_bus_profile.dart';


class GetSearchBusesList extends StatefulWidget {
  final String documentId;

  GetSearchBusesList({required this.documentId});

  @override
  State<GetSearchBusesList> createState() => _GetSearchBusesListState();
}

class _GetSearchBusesListState extends State<GetSearchBusesList> {
  @override
  Widget build(BuildContext context) {

    CollectionReference buses = FirebaseFirestore.instance.collection('buses');

    return FutureBuilder<DocumentSnapshot>(
      future: buses.doc(widget.documentId).get(),
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

                          Image.asset('lib/images/location_bus.png',width: 100,height: 100,),

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
                                    builder: (context) => ViewBusProfilePage(documnetID: widget.documentId,)),
                              );
                            },
                            child: Container(
                              height: 35,
                              width: 100,
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

                          SizedBox(width: 10,),

                          //Booking Button
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TicketBookingPage(documnetID: widget.documentId,)),
                              );
                            },
                            child: Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: Color(0xFF937047)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text('Booking',style: TextStyle
                                  (color: Colors.white,fontWeight: FontWeight.bold),)),
                              ),
                            ),
                          ),

                          SizedBox(width: 10,),

                          //Live Button
                          FutureBuilder(
                              future: buses.doc(widget.documentId).get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return '${data['bus_location_status']}' == 'Online'
                                  //Button True
                                      ? GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LiveBusLocationPage(documnetID: widget.documentId)),
                                      );
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          color: Color(0xFF937047)
                                      ),
                                      child: Center(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Live',style: TextStyle
                                          (color: Colors.white,fontWeight: FontWeight.bold),),
                                      )),
                                    ),
                                  )
                                  //Button Fails
                                      : GestureDetector(
                                    onTap: (){

                                    },
                                    child: Container(
                                      height: 35,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          color: Colors.black12
                                      ),
                                      child: Center(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Live',style: TextStyle
                                          (color: Colors.white,fontWeight: FontWeight.bold),),
                                      )),
                                    ),
                                  );
                                }
                                //Loading
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LiveBusLocationPage(documnetID: widget.documentId)),
                                    );
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        color: Color(0xFF937047)
                                    ),
                                    child: Center(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Live',style: TextStyle
                                        (color: Colors.white,fontWeight: FontWeight.bold),),
                                    )),
                                  ),
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              //check Online Status
              Expanded(
                child: FutureBuilder(
                    future: buses.doc(widget.documentId).get(),
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