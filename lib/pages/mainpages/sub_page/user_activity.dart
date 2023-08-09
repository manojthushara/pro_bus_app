import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/qr_pages/qr_view_user.dart';

import '../../../first_pages/navigator_bar.dart';
import 'delete_passenger_ticket.dart';
import 'edit_pagees/edit_bus_profile.dart';

class UserActivityPage extends StatefulWidget {


  @override
  State<UserActivityPage> createState() => _UserActivityPageState();
}

class _UserActivityPageState extends State<UserActivityPage> {

  final user = FirebaseAuth.instance.currentUser!;
  String getticket = " ";
  String getfrom = " ";
  String getto = " ";
  String get_bus_no = " ";
  String getsheet = ' ';

  //get firebase details
  Future getBusRoot() async {
    await FirebaseFirestore.instance
        .collection('passengers')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((documentw) {
        setState(() async {
          getticket = '${documentw['sheet_no']}';
          getfrom = '${documentw['form']}';
          getto = '${documentw['to']}';
          get_bus_no = '${documentw['bus_no']}';
          getsheet = '${documentw['sheet_no']}';

        });
      }),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        child: Column(
          children: [
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text(
                      'My Activity',
                      style: TextStyle(
                        color: Color(0xFF241f1c),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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

            //3D button
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Container(
                      height: 400,
                      width: 320,
                      child: Column(

                        children: [
                          SizedBox(height: 20,),
                          Icon(
                            Icons.favorite,
                            size: 50,
                            color:  Colors.redAccent,
                          ),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: Text(
                                    'My Tickets',
                                    style: TextStyle(
                                      color: Color(0xFF241f1c),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
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

                          SizedBox(height: 20,),

                          //bus ticket
                          FutureBuilder(
                              future: getBusRoot(),
                              builder: (context, snapshot){
                                if (snapshot.connectionState ==
                                    ConnectionState.done){
                                  return getticket == ' ' ?
                                  // not available
                                  Container(
                                    height: 250,
                                    width: 280,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      border: Border.all(
                                        width: 2, //                   <--- border width here
                                      ),
                                      color: Colors.black12,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(height: 20,),
                                          Text("Bus Tickets not Available",style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Image.asset('lib/images/empty.png',width: 100,height: 100,),
                                          SizedBox(height: 20,),
                                        ],
                                      ),
                                    ),
                                  )
                                  //Bus Ticket
                                      : Container(
                                    height: 250,
                                    width: 280,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      border: Border.all(
                                        width: 2, //
                                      ),
                                      color: Colors.black12,
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          Text("Bus Ticket",style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.asset('lib/images/qr.png',width: 100,height: 100,),
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(getfrom,style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  Text('to',style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  Text(getto,style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  Text(get_bus_no,style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  SizedBox(
                                                 height: 20,
                                               ),

                                                  Text('Sheet No: '+getsheet,style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20,),
                                          //View button
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => QRcodeViewUser(getsheet : getsheet)),
                                                );},
                                                child: Container(
                                                  height: 40,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10),
                                                        bottomRight: Radius.circular(10),
                                                        bottomLeft: Radius.circular(10)),
                                                    color: Color(0xFF937047),
                                                  ),
                                                  child: Center(child: Text('View',style:
                                                  TextStyle(fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold),)),
                                                ),
                                              ),

                                              SizedBox(width: 20,),

                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => DeleteUserTicket(getsheet : getsheet, get_bus_no : get_bus_no)),
                                                  );
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10),
                                                        bottomRight: Radius.circular(10),
                                                        bottomLeft: Radius.circular(10)),
                                                    color: Color(0xFF937047),
                                                  ),
                                                  child: Center(child: Text('Delete',style:
                                                  TextStyle(fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold),)),
                                                ),
                                              )
                                            ],
                                          )

                                        ],
                                      ),
                                    ),
                                  );
                                }
                                //loading...
                                return Container(
                                  height: 250,
                                  width: 280,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    color: Colors.black12,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              offset: Offset(6, 6),
                              blurRadius: 15,
                              spreadRadius: 1,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-6, -6),
                              blurRadius: 15,
                              spreadRadius: 1,
                            )
                          ]
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        )
    );
  }
}
