
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/search_page.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/booking_pages/bus_book_sheet.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/bus_home.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/home_button/home_bookig_button.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/home_button/home_map_button.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/home_button/home_view_button.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/qr_pages/qr_scanner.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/time_table_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;
  String getbusno = " ";

  //get bus account method
  Future getBus() async {
    await FirebaseFirestore.instance
        .collection('buses')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((documentw) {
        setState(() async {
          getbusno = '${documentw['bus_name']}';
        });
      }),
    );
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFe7dac7),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFF241f1c)),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFe7dac7),
      appBar: AppBar(
        backgroundColor: Color(0xFF937047),
        title: Text('Home'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            //Logo and Heading
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  //logo
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10,left: 30,right: 0),
                    child: Image.asset('lib/images/main_logo.png',width: 140,height: 140,),
                  ),

                  Column(
                    children: [

                      Center(
                          child: Text('Online Bus Reservation',style:
                          TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple
                          ),)),

                      SizedBox(height: 10,),

                      Center(
                          child: Text('   Get on task with \nOnline bus Booking \n      the smarter \n      way to travel',style:
                      TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                      ),)),
                    ],
                  ),
                ],
              ),
            ),

            //horizontal scrollview
            Container(
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: Color(0xFF937047),
                      ),
                      width: 250,
                      child: Image.asset('lib/images/ad01.jpg',width: 250,height: 170,),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: Color(0xFF937047),
                      ),
                      width: 250,
                      child: Image.asset('lib/images/ad02.jpg',width: 250,height: 170,),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: Color(0xFF937047),
                      ),
                      width: 250,
                      child: Image.asset('lib/images/ad03.jpg',width: 250,height: 170,),
                    ),
                  ),
                ],
              ),
            ),

            //Main Button
          SizedBox(
          height: 365,
          child: Container(
            height: 365,
            color: Colors.black12,
            child: FutureBuilder(
              future: getBus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: getbusno == " "
                        ? [
                          //Passenger interface
                      Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 10),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomeViewButton()),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Center(
                                            child: Container(
                                              height: 150,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(30),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.shade500,
                                                      offset: Offset(6, 6),
                                                      blurRadius: 15,
                                                      spreadRadius: 1,
                                                    ),
                                                    BoxShadow(
                                                      color: Colors.white30,
                                                      offset: Offset(-6, -6),
                                                      blurRadius: 15,
                                                      spreadRadius: 1,
                                                    )
                                                  ]
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset('lib/images/online_bus.png',width: 100,height: 100,),
                                                  Text('Online Bus',style: TextStyle(color: Colors.black,fontSize: 18),)
                                                  //bus ticket
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10, top: 10),
                                  child: Column(
                                    children: [

                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomeBookingButton()),
                                          );
                                        },

                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Center(
                                            child: Container(
                                              height: 150,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(30),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.shade500,
                                                      offset: Offset(6, 6),
                                                      blurRadius: 15,
                                                      spreadRadius: 1,
                                                    ),
                                                    BoxShadow(
                                                      color: Colors.white30,
                                                      offset: Offset(-6, -6),
                                                      blurRadius: 15,
                                                      spreadRadius: 1,
                                                    )
                                                  ]
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset('lib/images/online_book.png',width: 100,height: 100,),
                                                  Text('Online Booking',style: TextStyle(color: Colors.black,fontSize: 18),)
                                                  //bus ticket
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomeMapButton()),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: Center(
                                            child: Container(
                                              height: 150,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(30),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.shade500,
                                                      offset: Offset(6, 6),
                                                      blurRadius: 15,
                                                      spreadRadius: 1,
                                                    ),
                                                    BoxShadow(
                                                      color: Colors.white30,
                                                      offset: Offset(-6, -6),
                                                      blurRadius: 15,
                                                      spreadRadius: 1,
                                                    )
                                                  ]
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset('lib/images/map_view.png',width: 100,height: 100,),
                                                  Text('View Map',style: TextStyle(color: Colors.black,fontSize: 18),)
                                                  //bus ticket
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => TimeTablePage()),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: Center(
                                            child: Container(
                                              height: 150,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(30),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.shade500,
                                                      offset: Offset(6, 6),
                                                      blurRadius: 15,
                                                      spreadRadius: 1,
                                                    ),
                                                    BoxShadow(
                                                      color: Colors.white30,
                                                      offset: Offset(-6, -6),
                                                      blurRadius: 15,
                                                      spreadRadius: 1,
                                                    )
                                                  ]
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset('lib/images/time_table.png',width: 100,height: 100,),
                                                  Text('Time Table',style: TextStyle(color: Colors.black,fontSize: 18),)
                                                  //bus ticket
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ) ]
                        : [
                          //Bus Account Interface
                      BusHomePage()],
                  );
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 10),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Center(
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade500,
                                              offset: Offset(6, 6),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            ),
                                            BoxShadow(
                                              color: Colors.white30,
                                              offset: Offset(-6, -6),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            )
                                          ]
                                      ),
                                      child:   Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Center(
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade500,
                                              offset: Offset(6, 6),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            ),
                                            BoxShadow(
                                              color: Colors.white30,
                                              offset: Offset(-6, -6),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            )
                                          ]
                                      ),
                                      child:   Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Center(
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade500,
                                              offset: Offset(6, 6),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            ),
                                            BoxShadow(
                                              color: Colors.white30,
                                              offset: Offset(-6, -6),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            )
                                          ]
                                      ),
                                      child:   Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Center(
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade500,
                                              offset: Offset(6, 6),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            ),
                                            BoxShadow(
                                              color: Colors.white30,
                                              offset: Offset(-6, -6),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            )
                                          ]
                                      ),
                                      child:   Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        )

        ],
        ),
      )
    );
  }
}
