import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/booking_pages/triple_sheet.dart';
import 'double_sheet.dart';

class TicketBookingPage extends StatelessWidget {
  String documnetID;

  TicketBookingPage ({required this.documnetID,});

  @override
  Widget build(BuildContext context) {

    CollectionReference buses = FirebaseFirestore.instance.collection('buses');

    return FutureBuilder<DocumentSnapshot>(
        future: buses.doc(documnetID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;


            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF937047),
                title: Text('Bus List'),
              ),
              backgroundColor: Color(0xFFe7dac7),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [

                      //Heading
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey[800],
                                thickness: 3,
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                              child: Text(
                                'Booking Sheet',
                                style: TextStyle(
                                  color: Color(0xFF241f1c),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color(0xFF241f1c),
                                thickness: 3,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10,),

                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black12,
                          ),
                          height: 950,
                          width: 340,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                // Bus Details
                                Text('${data['bus_no']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                Text('${data['start_location']} to ${data['end_location']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                Text('${data['bus_root_no']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                Text('${data['bus_name']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                                Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 20, right: 10, left: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              Text(
                                                "Booked",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              Text(
                                                "Empty",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 20, right: 10, left: 20),
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            height: 35,
                                            width: 290,
                                            child: Center(
                                              child: Text(
                                                'Font Side',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 20,
                                        ),

                                        //Bus sheet selection function
                                        FutureBuilder(
                                          future: buses.doc(documnetID).get(),
                                            builder: ((context, snapshot){
                                              if('${data['bus_type']}'=='Double Sheet') {
                                                return DoubleSheetPage(documnetID: documnetID,);
                                              }
                                              return TripleSheetPage(documnetID: documnetID,);
                                        }
                                        ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container(color: Colors.white,);
        }
        )
    );
  }
}
