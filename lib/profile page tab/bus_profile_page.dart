import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/mainpages/sub_page/edit_pagees/edit_bus_profile.dart';
import '../pages/mainpages/sub_page/register_bus.dart';
import '../pages/mainpages/sub_page/get_details_pages/get_probus_details.dart';

class BusProfilePage extends StatefulWidget {
   BusProfilePage({super.key});

  @override
  State<BusProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<BusProfilePage> {


final user = FirebaseAuth.instance.currentUser!;
File? _photo;
String bus_dp_url = " ";
String getbusname = " ";
String bus_cover_url = " ";
String getbusno = " ";
String get_user_dp_url = " ";

//getuserdetails
List<String> docids = [];
//getProbus details list

//get user
Future getUser() async {
  await FirebaseFirestore.instance.collection('buses').where('email', isEqualTo: user?.email).get().then(
        (snapshot) => snapshot.docs.forEach((document) {
      docids.add(document.reference.id);
    }),
  );
}

//get bus details
Future getBusDetails() async {
  await FirebaseFirestore.instance.collection('buses').where('email', isEqualTo: user?.email).get().then(
        (snapshot) => snapshot.docs.forEach((documentw) {

      setState(() async {
        getbusno = '${documentw['bus_no']}';
        bus_dp_url = '${documentw['bus_dp_image']}';
        getbusname = '${documentw['bus_name']}';
        bus_cover_url = '${documentw['bus_cover_image']}';
      });

    }),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe7dac7),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
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
                        const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                        child: Text(
                          'ProBus Profile',
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

                SizedBox(height: 10),

                // check bus account have or not
                SizedBox(
                  height: 830.0,
                  child: Container(
                    height: 1280,
                    child: Expanded(
                      child: FutureBuilder(
                        future: getBusDetails(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return getbusno == " "

                            // Add bus account
                                ? Column(
                              children: [
                                  GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegisterBus()),
                                    );
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF937047),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Add ProBus Account',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 0),
                              ],
                            ) :

                                // View Bus Account
                            Container(

                              child: Container(

                                child: Container(
                                  height: 600,
                                  width: 330,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    color: Colors.black12,
                                  ),
                                  child: Center(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        SizedBox(height: 40),

                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          margin: const EdgeInsets.symmetric(horizontal: 0),
                                          decoration: BoxDecoration(
                                            color: Colors.white24,
                                            borderRadius: BorderRadius.circular(10),
                                          ),

                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Row(
                                                  children: [

                                                    Container(

                                                      child: CircleAvatar(
                                                        radius: 55,
                                                        backgroundColor: Color(0xFF937047),
                                                        child: _photo != null
                                                            ? ClipRRect(
                                                          borderRadius: BorderRadius.circular(100),
                                                          child: Image.file(
                                                              _photo!,
                                                              height: 100, width: 100, fit: BoxFit.fill
                                                          ),
                                                        )
                                                            : Container(
                                                          child: Expanded(
                                                            child: FutureBuilder(
                                                              future: getBusDetails(),
                                                              builder: (context, snapshot) {
                                                                if (snapshot.connectionState ==
                                                                    ConnectionState.done) {
                                                                  return bus_dp_url == " "
                                                                      ? const Icon(
                                                                    Icons.account_circle, size: 110, color: Color(0xFFe7dac7),)
                                                                      :
                                                                  CircleAvatar(
                                                                    radius: 60,
                                                                    backgroundColor: Colors.white,
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(100), child:
                                                                    Image.network(bus_dp_url, height: 100,
                                                                      width: 100,
                                                                      fit: BoxFit.fill,),),
                                                                  );
                                                                }
                                                                return Center(child: CircularProgressIndicator(
                                                                  color: Colors.black,));
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                      child: Column(
                                                        children: [

                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                                            child: Expanded(
                                                              child: FutureBuilder(
                                                                future: getBusDetails(),
                                                                builder: (context, snapshot) {
                                                                  if (snapshot.connectionState == ConnectionState.done) {
                                                                    return getBusDetails() == " " ? Center(
                                                                        child: CircularProgressIndicator(
                                                                          color: Colors.black,)) : Text(
                                                                      getbusno, style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 20,
                                                                    ),
                                                                    );
                                                                  }
                                                                  return Text('Loading...');
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.only(left: 5,),
                                                            child: Expanded(

                                                              child: FutureBuilder(
                                                                future: getBusDetails(),
                                                                builder: (context, snapshot) {
                                                                  if (snapshot.connectionState == ConnectionState.done) {
                                                                    return getBusDetails() == " " ? Center(
                                                                        child: CircularProgressIndicator(
                                                                          color: Colors.black,)) : Text(
                                                                      getbusname, style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 20,
                                                                    ),
                                                                    );
                                                                  }
                                                                  return Text('__');
                                                                },
                                                              ),
                                                            ),
                                                          ),

                                                          SizedBox(height: 10,),

                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => const EditBusProfilePage()),
                                                              );
                                                            },
                                                            child: Container(
                                                                height: 35,
                                                                width: 100,
                                                                decoration: BoxDecoration(
                                                                  color: Color(0xFF937047),
                                                                  borderRadius: BorderRadius.circular(20),
                                                                ),
                                                                child: Icon(
                                                                  Icons.edit,
                                                                  color: Colors.white,)
                                                            ),
                                                          ),
                                                          SizedBox(height: 10,),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 20,),

                                              Container(
                                                child: Center(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        child: Container(
                                                          height: 150,
                                                          width: 300,
                                                          child: _photo != null
                                                              ? ClipRRect(
                                                            borderRadius: BorderRadius.circular(15),
                                                            child: Image.file(
                                                              _photo!,
                                                              width: 150,
                                                              height: 300,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )
                                                              : Container(
                                                            child:  Expanded(
                                                              child: FutureBuilder(
                                                                future: getBusDetails(),
                                                                builder: (context, snapshot) {
                                                                  if (snapshot.connectionState == ConnectionState.done) {
                                                                    return bus_cover_url == " " ? const Icon(
                                                                        Icons.add_photo_alternate_outlined, size: 50, color: Color(0xFFe7dac7)) :
                                                                    Container(
                                                                      child: ClipRRect(borderRadius: BorderRadius.circular(15),child:
                                                                      Padding(
                                                                        padding: const EdgeInsets.symmetric(horizontal: 30),
                                                                        child: Image.network(bus_cover_url, height: 150, width: 300, fit: BoxFit.fill,),
                                                                      ),),
                                                                    );
                                                                  }return Center(child: CircularProgressIndicator(color: Colors.black,));
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 20,),

                                        Expanded(
                                          child: FutureBuilder(
                                            future: getUser(),
                                            builder: (context, snapshot) {
                                              return ListView.builder(
                                                itemCount: docids.length.sign,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    title: GetProBusDetails(documentId: docids[index],),
                                                  );
                                                },);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Center(child: CircularProgressIndicator(
                            color: Colors.black,));
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
