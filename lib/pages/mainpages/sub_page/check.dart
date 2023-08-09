import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/view_feedback.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bus_feedback.dart';
class Check extends StatefulWidget {
  final String documentId;

  Check({required this.documentId});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {

  File? _photo;
  final user = FirebaseAuth.instance.currentUser!;
  String getbusno = ' ';
  String getbusname = ' ';
  String get_user_dp_url = ' ';
  String getStartLocation = ' ';
  String getEndLocation = ' ';
  String getStartTime = ' ';
  String getEndtime = ' ';
  String getbusaddress = ' ';
  String getregisterno = ' ';
  String getsheet = ' ';
  String getrootno = ' ';
  String getcontact = ' ';
  String getemail = ' ';
  String getbusOwner = ' ';


  //get bus account method
  Future getUserProfilePicture() async {
    await FirebaseFirestore.instance.collection('buses').where('email', isEqualTo: widget.documentId).get().then(
          (snapshot) => snapshot.docs.forEach((documentw) {

        setState(() async {
          getbusname = '${documentw['bus_name']}';
          getbusno = '${documentw['bus_no']}';
          get_user_dp_url = '${documentw['bus_dp_image']}';
          getEndLocation = '${documentw['end_location']}';
          getStartLocation = '${documentw['start_location']}';
          getStartTime = '${documentw['start_time']}';
          getEndtime = '${documentw['end_time']}';
          getbusaddress = '${documentw['bus_address']}';
          getregisterno = '${documentw['bus_register_no']}';
          getsheet = '${documentw['bus_type']}';
          getrootno = '${documentw['bus_root_no']}';
          getcontact = '${documentw['bus_contact']}';
          getbusOwner = '${documentw['bus_owner']}';
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus List'),
        backgroundColor: Color(0xFF937047),
      ),
      backgroundColor: Color(0xFFe7dac7),
      body: Container(

        child: Column(
          children: [
            SizedBox(height: 10,),

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

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
              ),
              height: 600,
              width: 360,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                        child: Container(
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Color(0xFF937047),
                            child: _photo != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                _photo!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                                : Container(
                              child:  Expanded(
                                child: FutureBuilder(
                                  future: getUserProfilePicture(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      return get_user_dp_url == " " ? const Icon(
                                          Icons.account_circle, size: 110, color: Color(0xFFe7dac7)) :
                                      CircleAvatar(
                                        radius: 55,
                                        backgroundColor: Colors.white,
                                        child: ClipRRect(borderRadius: BorderRadius.circular(100),child:
                                        Image.network(get_user_dp_url, height: 100, width: 100, fit: BoxFit.cover,),),
                                      );
                                    }return Center(child: CircularProgressIndicator(color: Colors.black,));
                                  },
                                ),
                              ),
                            ),

                          ),
                        ),
                      ),

                      FutureBuilder(
                          future: getUserProfilePicture(),
                          builder: (context, snapshot){
                            if (snapshot.connectionState == ConnectionState.done){
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(getbusno, style: TextStyle(fontSize: 20,),),

                                        Text(getbusname, style: TextStyle(fontSize: 16,),),

                                        Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Text(getEndLocation, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                            Text(' to ', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                            Text(getStartLocation, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Text(getStartTime, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                            Text(' to ', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                            Text(getEndtime, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                          ],
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              );
                            }
                            return Container();
                          }
                      )
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black12,
                    ),
                    height: 250,
                    width: 320,
                    child: FutureBuilder(
                        future: getUserProfilePicture(),
                        builder: (context, snapshot){
                          if (snapshot.connectionState == ConnectionState.done){
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 10,),
                                    Image.asset('lib/images/busprofile.png',width: 140,height: 70,),
                                    SizedBox(height: 5,),
                                    Text('Owner :'+ getbusOwner,style: TextStyle(fontSize: 16,),),
                                    SizedBox(height: 5,),
                                    Text('Address : '+getbusaddress,style: TextStyle(fontSize: 16,),),
                                    SizedBox(height: 5,),
                                    Text('Register No : '+ getregisterno,style: TextStyle(fontSize: 16,),),
                                    SizedBox(height: 5,),
                                    Text('Sheet : '+ getsheet,style: TextStyle(fontSize: 16,),),
                                    SizedBox(height: 10,),
                                    //Buttons
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        //Call
                                        GestureDetector(
                                          onTap: () {
                                            String phoneNumber = getcontact;
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
                                                  builder: (context) => BusFeedBackPage(documnetID: widget.documentId)),
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
                                                  builder: (context) => ViewFeedbackPage(documnetID: widget.documentId)),
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
                              ],
                            );
                          }
                          return Container();
                        }
                    ),
                  ),

                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF937047),
                        ),
                        child: Center(child: Text('Booking',style:
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),)),
                      ),

                      SizedBox(width: 20,),

                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF937047),
                        ),
                        child: Center(child: Text('Live',style:
                        TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),)),
                      ),
                    ],
                  )
                ],
              ),
            ),




          ],
        ),
      ),
    );
  }
}
