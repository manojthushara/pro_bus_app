

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/bus_feedback.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/view_feedback.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewBusProfilePage extends StatelessWidget {
  String documnetID;

  ViewBusProfilePage ({required this.documnetID,});

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
                            'Bus Profile',
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

                  //Bus Profile
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                          color: Colors.black12,
                      ),
                        height: 620,
                        width: 340,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              //bus cover image
                              Container(
                                  height: 100,
                                  width: 300,
                                  padding: EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                  ),
                                  child: Image.network('${data['bus_cover_image']}',width: 300,height: 100,)
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //bus dp image
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10,left: 20,right: 12),
                                    child: Container(
                                        height: 100,
                                        width: 100,
                                        padding: EdgeInsets.all(1),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        child: Image.network('${data['bus_dp_image']}',width: 100,height: 100,)
                                    ),
                                  ),

                                  //bus details
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10,left: 0,right: 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black12,
                                      ),
                                      height: 100,
                                      width: 186,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 8,),
                                          Text('${data['bus_name']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                          Text('${data['bus_no']}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                          SizedBox(height: 5,),
                                          Text('${data['bus_root']}',style: TextStyle(fontSize: 16,)),
                                          Text('${data['bus_root_no']}',style: TextStyle(fontSize: 16,)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //bus name
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  height: 270,
                                  width: 300,
                                  padding: EdgeInsets.all(1),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)),
                                  ),

                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Image.asset('lib/images/busprofile.png',width: 140,height: 70,),
                                      SizedBox(height: 5,),
                                      Text('Owner : ${data['bus_owner']}',style: TextStyle(fontSize: 16,),),
                                      SizedBox(height: 5,),
                                      Text('Address : ${data['bus_address']}',style: TextStyle(fontSize: 16,),),
                                      SizedBox(height: 5,),
                                      Text('Register No : ${data['bus_register_no']}',style: TextStyle(fontSize: 16,),),
                                      SizedBox(height: 5,),
                                      Text('Sheet : ${data['bus_type']}',style: TextStyle(fontSize: 16,),),
                                      SizedBox(height: 5,),
                                      Text('Email : ${data['email']}',style: TextStyle(fontSize: 16,),),
                                      SizedBox(height: 10,),
                                      //Buttons
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          //Call
                                          GestureDetector(
                                            onTap: () {
                                              String phoneNumber = '${data['bus_contact']}';
                                              String uri = 'tel:$phoneNumber';
                                              launch(uri);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(right: 20,left: 20),
                                              child: CircleAvatar(
                                                  backgroundColor: Color(0xFF937047),
                                                  child: Icon(
                                                    Icons.call,
                                                    color: Colors.white,)
                                              ),
                                            ),
                                          ),

                                          //give feedback
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => BusFeedBackPage(documnetID: documnetID)),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(right: 20,left: 20),
                                              child: CircleAvatar(
                                                  backgroundColor: Color(0xFF937047),
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.white,)
                                              ),
                                            ),
                                          ),

                                          //Feedback
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ViewFeedbackPage(documnetID: documnetID)),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(right: 20,left: 20),
                                              child: CircleAvatar(
                                                  backgroundColor: Color(0xFF937047),
                                                  child: Icon(
                                                    Icons.feedback,
                                                    color: Colors.white,)
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //Bus Driver conductor details


                              SizedBox(height: 30,),


                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                  margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF937047),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "CANCEL",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
            return Container(
          );
          }
          )
        );
    }
}
