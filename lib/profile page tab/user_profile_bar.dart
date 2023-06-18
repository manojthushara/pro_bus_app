import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/mainpages/sub_page/edit_user_profile.dart';
import '../pages/mainpages/sub_page/get_user_details.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  File? _photo;
   String bus_dp_url = " ";
   String getname = " ";

   String bus_cover_url = " ";

   String getbusno = " ";

   String get_user_dp_url = " ";

//profile pictur
  Future getUserProfilePicture() async {
    await FirebaseFirestore.instance.collection('passengers').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((documentw) {

        setState(() async {
          getname = '${documentw['name']}';
          bus_dp_url = '${documentw['bus_dp_image']}';
          bus_cover_url = '${documentw['bus_cover_image']}';
          getbusno = '${documentw['bus_no']}';
          get_user_dp_url = '${documentw['user_dp_image']}';

        });

      }),
    );
  }
  //getuserdetails
  List<String> docids = [];
  //get user
  Future getUser() async {
    await FirebaseFirestore.instance.collection('passengers').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        print(document.reference);
        docids.add(document.reference.id);
      }),
    );
  }

  //sign out user method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
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
                          'Passenger Profile',
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
                //Login and edit buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    //Edit page Button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditUserProfilePage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 15,),
                        child: CircleAvatar(
                            backgroundColor: Color(0xFF937047),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,)
                        ),
                      ),
                    ),
                    //Logout Button
                    GestureDetector(
                      onTap: (signUserOut),
                      child: Container(
                        padding: const EdgeInsets.only(right: 25,),
                        child: CircleAvatar(
                            backgroundColor: Color(0xFF937047),
                            child: Icon(
                              Icons.logout,
                              color: Colors.white,)
                        ),
                      ),
                    ),
                  ],
                ),
                //image Averter
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
                          future: getUserProfilePicture(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return get_user_dp_url == " "
                                  ? const Icon(
                                Icons.account_circle, size: 110, color: Color(0xFFe7dac7),)
                                  :
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100), child:
                                Image.network(get_user_dp_url, height: 100, width: 100, fit: BoxFit.fill,),),
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
                SizedBox(height: 10),
                Center(
                  child: Expanded(
                    child: FutureBuilder(
                      future: getUserProfilePicture(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return getUserProfilePicture() == " " ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,)) : Text(
                            getname, style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          );
                        }
                        return Text('__');
                      },
                    ),
                  ),
                ),

                Container(
                  child: Center(
                    child: Text(
                      "Now you are Smart Passenger...", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //User details
                Container(
                  height: 230,
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.black12,
                  ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        Expanded(
                          child: FutureBuilder(
                            future: getUser(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                itemCount: docids.length.sign,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: GetUserDetails(documentId: docids[index],),
                                  );
                                },);
                            },
                          ),
                        ),
                      ],
                    ),

                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
