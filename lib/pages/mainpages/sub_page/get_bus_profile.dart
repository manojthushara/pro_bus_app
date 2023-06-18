
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/components/my_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:pro_bus_app/components/my_textfield.dart';
import 'package:path/path.dart';

import 'bus_cover_pic.dart';


class GetBusProfilePage extends StatefulWidget {
  const GetBusProfilePage({Key? key}) : super(key: key);

  @override
  State<GetBusProfilePage> createState() => _GetBusProfilePageState();
}


class _GetBusProfilePageState extends State<GetBusProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  String imageurl = " ";
  String getemail = " ";
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

//Image Picker Funtion
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = '$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref('bus_dp_images/').child(destination);
      await ref.putFile(_photo!);
      var url = await ref.getDownloadURL();
      addBusImage(url);
    } catch (e) {
      print('error occured');
    }
  }

  Future addBusImage(String image) async {
    await FirebaseFirestore.instance.collection('passengers').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        try{
          FirebaseFirestore.instance.collection('passengers').doc(document.id).update({'bus_dp': image});
        } catch (e){
          print('filed');
        }
      }),
    );
  }

  final busNoController = TextEditingController();
  final busContactController = TextEditingController();
  final busOwnerController = TextEditingController();
  final busAddressController = TextEditingController();
  final busRegisterNoController = TextEditingController();
  final busRootController = TextEditingController();
  final busRootNoController = TextEditingController();
  final driverNameController = TextEditingController();
  final driverContactController = TextEditingController();
  final driverLicenceNoController = TextEditingController();
  final conductornameController = TextEditingController();
  final conductorConctactController = TextEditingController();

  @override
  void disponse() {
    busNoController.dispose();
    busContactController.dispose();
    busOwnerController.dispose();
    busAddressController.dispose();
    busRegisterNoController.dispose();
    busRootController.dispose();
    busRootNoController.dispose();
    driverNameController.dispose();
    driverContactController.dispose();
    driverLicenceNoController.dispose();
    conductornameController.dispose();
    conductorConctactController.dispose();
    getemail;
    super.dispose();
  }

  // Register button Function
  void registerbus() async {

    try {
      addUserDetails(
        busNoController.text.trim(),
        int.parse(busContactController.text.trim()),
        busOwnerController.text.trim(),
        busAddressController.text.trim(),
        busRegisterNoController.text.trim(),
        busRootController.text.trim(),
        int.parse(busRootNoController.text.trim()),
        driverNameController.text.trim(),
        int.parse(driverContactController.text.trim()),
        driverLicenceNoController.text.trim(),
        conductornameController.text.trim(),
        int.parse(conductorConctactController.text.trim()),
        getemail,
      );

    }on FirebaseFirestore catch (e) {
    }
  }
// Add bus details on firebase
  Future addUserDetails(
      String busNo,
      int busContact,
      String busOwner,
      String busAddress,
      String busRegisterNo,
      String busRoot,
      int busRootNo,
      String driverName,
      int driverContact,
      String driverLicenceNo,
      String conductorname,
      int conductorConctact,
      String email,

      ) async {
    await FirebaseFirestore.instance.collection('passengers').where('email', isEqualTo: user?.email).get().then(
            (snapshot) => snapshot.docs.forEach((document) {

              try{
                FirebaseFirestore.instance.collection('passengers').doc(document.id).update(
                    {
                      'bus_no': busNo,
                      'bus_contact': busContact,
                      'bus_owner': busOwner,
                      'bus_address': busAddress,
                      'bus_register_no': busRegisterNo,
                      'bus_root': busRoot,
                      'bus_root_no': busRootNo,
                      'driver_name': driverName,
                      'driver_contact': driverContact,
                      'driver_licence_no': driverLicenceNo,
                      'conductor_name': conductorname,
                      'conductor_contact': conductorConctact,
                      'email': email,
                    }
                );


              }on FirebaseAuthException catch (e) {
                // pop the loading circle

                // show error message
               (e.code);
              }
            }),
    );
  }
            // Get email for bus
    Future getProbusEmail() async {
    await FirebaseFirestore.instance.collection('passengers').where('email', isEqualTo: user?.email).get().then(
    (snapshot) => snapshot.docs.forEach((documents) {

    setState(() async {
      getemail = '${documents['email']}';
        });
    Text(getemail);

        }),
      );
    }

  //profile pictur
  Future getUserProfilePicture() async {
    await FirebaseFirestore.instance.collection('passengers').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((documentw) {

        setState(() async {
          imageurl = '${documentw['bus_dp']}';
        });
      }),
    );
  }


        @override
        Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF241f1c),

        ),
        backgroundColor: Color(0xFFe7dac7),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //
                  Container(
                    height: 1690,
                    width: 370,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10, top: 20, left: 10),
                            child: const Text(
                              "REGISTER",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),const SizedBox(
                            height: 5,
                          ),

                          Container(
                            child: FutureBuilder(
                              future: getProbusEmail(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Text('Current User: '+getemail);
                                }
                                return Center(child: CircularProgressIndicator(
                                  color: Colors.black,));
                              },
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
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                  child: Text(
                                    'Add ProBus Profile',
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
                        //Bus Profile Pic
                          Center(
                            child: Stack(
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
                                              return imageurl == " " ? const Icon(
                                                  Icons.account_circle, size: 110, color: Color(0xFFe7dac7)) :
                                              CircleAvatar(
                                                radius: 50,
                                                backgroundColor: Colors.white,
                                                child: ClipRRect(borderRadius: BorderRadius.circular(100),child:
                                                Image.network(imageurl, height: 100, width: 100, fit: BoxFit.fill,),),
                                              );
                                            }return Center(child: CircularProgressIndicator(color: Colors.black,));
                                          },
                                        ),
                                      ),
                                    ),

                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showPicker(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 4,
                                            color: Colors.white
                                        ),
                                        color: Color(0xFF937047),
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                  child: Text(
                                    'Add ProBus Cover',
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
                        // Bus Cover Pic
                          Container(
                            child: BusCoverPic(),
                          ),
                          const SizedBox(
                            height: 20,
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
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                  child: Text(
                                    'Add ProBus Details',
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
                          // Name feild
                          MyTextField(
                              controller: busNoController,
                              hintText: 'Bus Number',
                              obscureText: false),
                          const SizedBox(
                            height: 10,
                          ),
                          // Contact feild
                          MyTextField(
                              controller: busContactController,
                              hintText: 'Bus Contact',
                              obscureText: false),
                          const SizedBox(
                            height: 10,
                          ),

                          MyTextField(
                              controller: busOwnerController,
                              hintText: 'Bus Owner',
                              obscureText: false),
                          const SizedBox(
                            height: 10,
                          ),

                          MyTextField(
                              controller: busAddressController,
                              hintText: 'Bus Address',
                              obscureText: false),
                          const SizedBox(
                            height: 10,
                          ),

                          MyTextField(
                              controller: busRegisterNoController,
                              hintText: 'Bus Register No',
                              obscureText: false),
                          const SizedBox(
                            height: 10,
                          ),

                          MyTextField(
                              controller: busRootController,
                              hintText: 'Bus Root',
                              obscureText: false),
                          const SizedBox(
                            height: 10,
                          ),

                          MyTextField(
                              controller: busRootNoController,
                              hintText: 'Bus Root No',
                              obscureText: false),
                          const SizedBox(
                            height: 15,
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
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                  child: Text(
                                    'Bus Driver Details',
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

                          const SizedBox(
                            height: 20,
                          ),
                          // Name feild
                          MyTextField(
                              controller: driverNameController,
                              hintText: 'Name',
                              obscureText: false),
                          const SizedBox(
                            height: 10,
                          ),
                          // Name feild
                          MyTextField(
                              controller: driverContactController,
                              hintText: 'Contact',
                              obscureText: false),
                          const SizedBox(
                            height: 10,
                          ),
                          // Name feild
                          MyTextField(
                              controller: driverLicenceNoController,
                              hintText: 'Licence No',
                              obscureText: false),
                          const SizedBox(
                            height: 15,
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
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                  child: Text(
                                    'Bus Conductor Details',
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

                          const SizedBox(
                            height: 20,
                          ),
                          // Name feild
                          MyTextField(
                              controller: conductornameController,
                              hintText: 'Name',
                              obscureText: false),
                          const SizedBox(
                            height: 10,
                          ),
                          // Name feild
                          MyTextField(
                              controller: conductorConctactController,
                              hintText: 'Contact',
                              obscureText: false),
                          const SizedBox(
                            height: 15,
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
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                  child: Text(
                                    'Register All Details',
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
                          const SizedBox(
                            height: 25,
                          ),
                          MyButton(
                            text: "Register",
                            onTop: (registerbus),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MyButton(
                            text: "Cancel",
                            onTop: (){
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  )

                ],
              ),
            ),

          ),
        ),
      );
    }
  }



