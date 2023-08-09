import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/get_details_pages/get_location_bus.dart';
import '../pages/mainpages/sub_page/user_activity.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final nameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  int a = 0;
  late String b;
  String getstartlocation = " ";
  String getendlocation = " ";
  String getbutype = " ";
  String getstatus = " ";
  final _online = "Offline";
  final _onlffline = "Online";
  String gettimeset = " ";
  final timestatus = "ON";
  final timestatusoff = "OFF";
  String getstarttime = " ";
  String getendtime = " ";
  String getbusno = " ";
  String _dropDownFrom = "From";
  String _dropDownTo = "To";
  String getsheeetno = " ";

  TimeOfDay _timeOfDay = TimeOfDay.now();
  TimeOfDay _timeOfDay1 = TimeOfDay.now();


  //show Time Picker
  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  //show Time Picker
  void _showTimePicker1() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay1 = value!;
      });
    });
  }


  //get firebase details
  Future getBusDetails() async {
    await FirebaseFirestore.instance
        .collection('buses')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((documentw) {
            setState(() async {
              getbusno = '${documentw['bus_no']}';
              getstartlocation = '${documentw['start_location']}';
              getendlocation = '${documentw['end_location']}';
              getbutype = '${documentw['bus_type']}';
              getstatus = '${documentw['bus_location_status']}';
              gettimeset = '${documentw['time_status']}';
              getstarttime = '${documentw['start_time']}';
              getendtime = '${documentw['end_time']}';
              getsheeetno = '${documentw['sheet_no']}';

            });
          }),
        );
  }

  @override
  void disponse() {
    _online;
    _onlffline;
    _timeOfDay;
    _timeOfDay1;
    timestatus;
    timestatusoff;
    _dropDownFrom;
    _dropDownTo;
    super.dispose();
  }

  //time to firebase
  void addtime() async {
    addTime(
      _timeOfDay.format(context).toString(),
      _timeOfDay1.format(context).toString(),
      timestatus,
      _dropDownFrom,
      _dropDownTo,
    );
  }

  Future addTime(
      String timestart,
      String timeend,
      String timestatus,
      String from,
      String to,
      ) async {
    await FirebaseFirestore.instance
        .collection('buses')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
        try {
          FirebaseFirestore.instance
              .collection('buses')
              .doc(document.id)
              .update({
            'start_time': timestart,
            'end_time': timeend,
            'time_status' : timestatus,
            'start_location' : from,
            'end_location' : to,
          });
          setState(() {

          });
        } on FirebaseAuthException catch (e) {}
      }),
    );
  }

//time to firebase
  void addtimestatus() async {
    offtime(
      timestatusoff,
    );
  }

  Future offtime(
    String timeoff
  ) async {
    await FirebaseFirestore.instance
        .collection('buses')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            try {
              FirebaseFirestore.instance
                  .collection('buses')
                  .doc(document.id)
                  .update({
                'time_status' : timeoff,
              });
              setState(() {

              });
            } on FirebaseAuthException catch (e) {}
          }),
        );
  }


  //online switch
  void onlinestuts() async {
    addStatusDetails(
      _online,
    );
  }

  final List<dynamic> docIDS = [];
   List<dynamic> pointlist = [];

   // Get sheet numbers
  Future getsheetnumbers() async {

    await FirebaseFirestore.instance
        .collection('buses')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {

        pointlist = document.get('book_sheet');
      }),
    );
  }

  //add online status
  Future addStatusDetails(String status) async {
    await FirebaseFirestore.instance
        .collection('buses')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            try {
              FirebaseFirestore.instance
                  .collection('buses')
                  .doc(document.id)
                  .update({
                'bus_location_status': status,
              });
              setState(() {});
            } on FirebaseAuthException catch (e) {}
          }),
        );
  }

  //offline switch
  void offlinestuts() async {
    addStatus1Details(
      _onlffline,
    );
  }

  Future addStatus1Details(String status) async {
    await FirebaseFirestore.instance
        .collection('buses')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            try {
              FirebaseFirestore.instance
                  .collection('buses')
                  .doc(document.id)
                  .update({
                'bus_location_status': status,
              });
              setState(() {});
            } on FirebaseAuthException catch (e) {}
          }),
        );
  }

  //delete method
  Future<void> deleteBusTicket(String number) async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('buses');
    QuerySnapshot querySnapshot = await collectionRef.where('email', isEqualTo: user?.email).get();
    DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
    DocumentReference documentRef = documentSnapshot.reference;

    documentRef.update({
      'book_sheet': FieldValue.arrayRemove([number]),
    })
        .then((value) {
      print('Value removed successfully');
    })
        .catchError((error) {
      print('Failed to remove value: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe7dac7),
      body: SingleChildScrollView(
          child: Container(
            height: 1000,
              child: FutureBuilder(
                future: getBusDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.done) {
                    return Column(
                      children: getbusno == " "
                        ? [
                          Container(
                          child: UserActivityPage())]
                          :
                          [
                            Center(
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
                                          'Activity',
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

                                // online button
                                Row(
                                  children: [
                                    Container(
                                      child: Expanded(
                                        child: FutureBuilder(
                                            future: getBusDetails(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return getstatus == "Online"
                                                    ? Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 100, right: 100),
                                                  child: GestureDetector(
                                                    onTap: onlinestuts,
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF937047),
                                                          borderRadius:
                                                          BorderRadius.circular(50),
                                                        ),
                                                        height: 50,
                                                        width: 300,
                                                        child: Center(
                                                          child: Text(
                                                            'You are Online',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.yellow),
                                                          ),
                                                        )),
                                                  ),
                                                )
                                                    : Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 100, right: 100),
                                                  child: GestureDetector(
                                                    onTap: offlinestuts,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                        BorderRadius.circular(50),
                                                      ),
                                                      height: 50,
                                                      width: 360,
                                                      child: Center(
                                                          child: Text(
                                                            'You are Offline',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white),
                                                          )),
                                                    ),
                                                  ),
                                                );
                                              }
                                              return Padding(
                                                padding:
                                                const EdgeInsets.only(left: 100, right: 100),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF937047),
                                                    borderRadius: BorderRadius.circular(50),
                                                  ),
                                                  height: 50,
                                                  width: 360,
                                                ),
                                              );
                                            }),
                                      ),

                                    ),

                                  ],
                                ),

                                SizedBox(height: 10,),

                                //Update location button
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 100, right: 100),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GetLocationBusPage()),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF937047),
                                        borderRadius:
                                        BorderRadius.circular(50),
                                      ),
                                      height: 50,
                                      width: 360,
                                      child: Center(
                                          child: Text(
                                            'Update Location',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                    ),
                                  ),
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
                                          'Bus Time Table',
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

                                Row(
                                  children: [
                                    Container(
                                      child: Expanded(
                                        child: FutureBuilder(
                                            future: getBusDetails(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return gettimeset == "ON"
                                                    ?
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 35,right: 35),
                                                  child: Container(
                                                    height: 125,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(20),
                                                          topRight: Radius.circular(20),
                                                          bottomRight: Radius.circular(20),
                                                          bottomLeft: Radius.circular(20)),
                                                      color: Colors.black12,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 20,),
                                                        //BUS root
                                                        Center(
                                                          child: Expanded(
                                                            child: FutureBuilder(
                                                              future: getBusDetails(),
                                                              builder: (context, snapshot) {
                                                                if (snapshot
                                                                    .connectionState ==
                                                                    ConnectionState.done) {
                                                                  return getBusDetails() == " "
                                                                      ? Center(
                                                                      child:
                                                                      CircularProgressIndicator(
                                                                        color:
                                                                        Colors.black,
                                                                      ))
                                                                      : Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(bottom: 10),
                                                                            child: Text(
                                                                              getstartlocation,
                                                                              style: TextStyle(
                                                                                color: Colors
                                                                                    .black,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .bold,
                                                                                fontSize: 20,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 10),
                                                                          Text('-',style: TextStyle(fontWeight: FontWeight.bold),),
                                                                          SizedBox(width: 10),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(bottom: 10),
                                                                            child: Text(
                                                                              getendlocation,
                                                                              style: TextStyle(
                                                                                color: Colors
                                                                                    .black,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .bold,
                                                                                fontSize: 20,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            getstarttime,
                                                                            style: TextStyle(
                                                                              color: Colors
                                                                                  .black,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                              fontSize: 20,
                                                                            ),
                                                                          ),
                                                                          Text('  -  ',style: TextStyle(fontWeight: FontWeight.bold),),
                                                                          Text(
                                                                            getendtime,
                                                                            style: TextStyle(
                                                                              color: Colors
                                                                                  .black,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                              fontSize: 20,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  );
                                                                }
                                                                return Text('Loading..');
                                                              },
                                                            ),
                                                          ),
                                                        ),

                                                        GestureDetector(
                                                          onTap: addtimestatus,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Container(
                                                                padding: const EdgeInsets.only(right: 10,top: 0),
                                                                child: CircleAvatar(
                                                                    backgroundColor: Color(0xFF937047),
                                                                    child: Icon(
                                                                      Icons.delete,
                                                                      color: Colors.white,)
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )

                                                    : Padding(
                                                  padding: const EdgeInsets.only(left: 35,right: 35),
                                                  child: Container(
                                                    height: 350,
                                                    width: 440,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(20),
                                                          topRight: Radius.circular(20),
                                                          bottomRight: Radius.circular(20),
                                                          bottomLeft: Radius.circular(20)),
                                                      color: Colors.black12,
                                                    ),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        children: [
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            child: Text('Set Time',
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.black,
                                                                )),
                                                          ),

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.black12,
                                                                ),
                                                                width: 130,
                                                                height: 50,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 20,right: 20),
                                                                  child: DropdownButton(
                                                                    dropdownColor: Color(0xFFe7dac7),
                                                                    // ignore: unnecessary_null_comparison
                                                                    hint: _dropDownFrom == null
                                                                        ? Text('Dropdown',style: TextStyle(color: Colors.black,fontSize: 14),)
                                                                        : Text(_dropDownFrom, style: TextStyle(color: Colors.black,fontSize: 14),),

                                                                    isExpanded: true,
                                                                    iconSize: 30.0,
                                                                    style: TextStyle(color: Colors.black),
                                                                    items: ['Kandy', 'Panadura','Colombo','Kegalle','Warakapola','Mathale','Dabulla'].map(
                                                                          (val) {
                                                                        return DropdownMenuItem<String>(
                                                                          value: val,
                                                                          child: Text(val),
                                                                        );
                                                                      },
                                                                    ).toList(),
                                                                    onChanged: (val) {
                                                                      setState(
                                                                            () {
                                                                          _dropDownFrom = val.toString();
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(width: 20,),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius.circular(20),
                                                                      topRight: Radius.circular(20),
                                                                      bottomRight: Radius.circular(20),
                                                                      bottomLeft: Radius.circular(20)),
                                                                  color: Colors.black12,
                                                                ),
                                                                width: 130,
                                                                height: 50,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 20,right: 20),
                                                                  child: DropdownButton(
                                                                    dropdownColor: Color(0xFFe7dac7),
                                                                    // ignore: unnecessary_null_comparison
                                                                    hint: _dropDownTo == null
                                                                        ? Text('Dropdown',style: TextStyle(color: Colors.black,fontSize: 14),)
                                                                        : Text(_dropDownTo , style: TextStyle(color: Colors.black,fontSize: 14),),

                                                                    isExpanded: true,
                                                                    iconSize: 30.0,
                                                                    style: TextStyle(color: Colors.black),
                                                                    items: ['Kandy', 'Panadura','Colombo','Kegalle','Warakapola','Mathale','Dabulla'].map(
                                                                          (val) {
                                                                        return DropdownMenuItem<String>(
                                                                          value: val,
                                                                          child: Text(val),
                                                                        );
                                                                      },
                                                                    ).toList(),
                                                                    onChanged: (val) {
                                                                      setState(
                                                                            () {
                                                                          _dropDownTo  = val.toString();
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                _timeOfDay.format(context).toString(),
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 80,
                                                              ),
                                                              Text(
                                                                _timeOfDay1.format(context).toString(),
                                                                style: TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          //show Time Set
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: _showTimePicker,
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft: Radius.circular(20),
                                                                        topRight: Radius.circular(20),
                                                                        bottomRight: Radius.circular(20),
                                                                        bottomLeft: Radius.circular(20)),
                                                                    color: Colors.black12,
                                                                  ),
                                                                  width: 130,
                                                                  height: 50,
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(
                                                                        10.0),
                                                                    child: Center(
                                                                      child: Text(
                                                                        'Start Time',
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 14),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ),
                                                              ),
                                                              SizedBox(width: 20,),
                                                              GestureDetector(
                                                                onTap: _showTimePicker1,
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft: Radius.circular(20),
                                                                        topRight: Radius.circular(20),
                                                                        bottomRight: Radius.circular(20),
                                                                        bottomLeft: Radius.circular(20)),
                                                                    color: Colors.black12,
                                                                  ),
                                                                  width: 130,
                                                                  height: 50,
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(
                                                                        10.0),
                                                                    child: Center(
                                                                      child: Text(
                                                                        'End Time',
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 14),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          GestureDetector(
                                                            onTap: addtime,
                                                            child: Container(
                                                              padding:
                                                              const EdgeInsets.all(20),
                                                              margin:
                                                              const EdgeInsets.symmetric(
                                                                  horizontal: 30,
                                                                  vertical: 5),
                                                              decoration: BoxDecoration(
                                                                color: Color(0xFF937047),
                                                                borderRadius:
                                                                BorderRadius.circular(50),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  "SUBMIT",
                                                                  style: const TextStyle(
                                                                    color: Colors.white,
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    fontSize: 14,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              return Padding(
                                                padding: const EdgeInsets.only(left: 35,right: 35),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(20),
                                                        topRight: Radius.circular(20),
                                                        bottomRight: Radius.circular(20),
                                                        bottomLeft: Radius.circular(20)),
                                                    color: Colors.black12,
                                                  ),
                                                  height: 125,
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
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
                                          "Booking Table",
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

                                SizedBox(
                                  height: 10,
                                ),
                                //Bus Sheet Booking function
                                Container(
                                  height: 380,
                                  width: 340,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                    color: Colors.black12,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            height: 380.0,
                                            child: Expanded(
                                              child: FutureBuilder(
                                                future: getsheetnumbers(),
                                                builder: (context, snapshot) {
                                                  return ListView.builder(
                                                      itemCount: pointlist.length,
                                                      itemBuilder: (context, index)
                                                      { if (pointlist[index] == ' '){
                                                        return Center();
                                                      }
                                                      return ListTile(
                                                        title: Padding(
                                                          padding: const EdgeInsets.only(top: 10),
                                                          child: Container(
                                                              height: 100,
                                                              width: 200,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius.circular(10),
                                                                    topRight: Radius.circular(10),
                                                                    bottomRight: Radius.circular(10),
                                                                    bottomLeft: Radius.circular(10)),
                                                                color: Colors.black12,
                                                              ),
                                                              child: Center(
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap: (){
                                                                          deleteBusTicket(pointlist[index]);
                                                                          setState(() {

                                                                          });
                                                                        },
                                                                        child: Container(
                                                                          padding: const EdgeInsets.only(right: 10,top: 0),
                                                                          child: CircleAvatar(
                                                                              backgroundColor: Color(0xFF937047),
                                                                              child: Icon(
                                                                                Icons.delete,
                                                                                color: Colors.white,)
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text('Sheet No: ',style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 19
                                                                      ),),
                                                                      Text(pointlist[index],style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 19,
                                                                          color: Colors.white
                                                                      ),),
                                                                      Text(' Booked',style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 19
                                                                      ),),

                                                                    ],
                                                                  ))),
                                                        ),
                                                      );
                                                      }
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          )]
                    );
                  }
                  return Center(child: CircularProgressIndicator(
                    color: Colors.black,));
                },
              ),
          ),
      ),
    );
  }
}
