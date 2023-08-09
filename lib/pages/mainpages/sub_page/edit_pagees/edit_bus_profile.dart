import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_bus_details.dart';
import 'edit_user_details_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class EditBusProfilePage extends StatefulWidget {

  const EditBusProfilePage({Key? key }) : super(key: key);

  @override
  State<EditBusProfilePage> createState() => _EditBusProfilePageState();
}

class _EditBusProfilePageState extends State<EditBusProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  File? _photo_cover;
  final ImagePicker _picker = ImagePicker();

  String bus_dp_url = " ";
  String getname = " ";
  String get_bus_cover_url = " ";

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

  Future imgFromGalleryCover() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75);

    setState(() {
      if (pickedFile != null) {
        _photo_cover = File(pickedFile.path);
        uploadFileBusCover();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCameraCover() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo_cover = File(pickedFile.path);
        uploadFileBusCover();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFileBusCover() async {
    if (_photo_cover == null) return;
    final fileName = basename(_photo_cover!.path);
    final destination = '$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref('profile_image/').child(destination);
      await ref.putFile(_photo_cover!);
      var url = await ref.getDownloadURL();
      print(url);
      addBusCover(url);
    } catch (e) {
      print('error occured');
    }
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = '$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref('profile_image/').child(destination);
      await ref.putFile(_photo!);
      var url = await ref.getDownloadURL();
      addBusDP(url);
    } catch (e) {
      print('error occured');
    }
  }

  Future addBusDP(String image) async {
    await FirebaseFirestore.instance.collection('buses').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        try{
          FirebaseFirestore.instance.collection('buses').doc(document.id).update({'bus_dp_image': image});
        } catch (e){
          print('filed');
        }
      }),
    );
  }

  Future uploadFileCover() async {
    if (_photo_cover == null) return;
    final fileName = basename(_photo_cover!.path);
    final destination = '$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref('profile_image/').child(destination);
      await ref.putFile(_photo_cover!);
      var url = await ref.getDownloadURL();
      addBusCover(url);
    } catch (e) {
      print('error occured');
    }
  }

  Future addBusCover(String imagecover) async {
    await FirebaseFirestore.instance.collection('buses').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        try{
          FirebaseFirestore.instance.collection('buses').doc(document.id).update({'bus_cover_image': imagecover});
        } catch (e){
          print('filed');
        }
      }),
    );
  }

  //getuserdetails
  List<String> docids = [];
  Future getBus() async {
    await FirebaseFirestore.instance.collection('buses').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        docids.add(document.reference.id);
      }),
    );
  }

//profile pictur
  Future getUserProfilePicture() async {
    await FirebaseFirestore.instance.collection('buses').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((documentw) {

        setState(() async {
          bus_dp_url = '${documentw['bus_dp_image']}';
          get_bus_cover_url = '${documentw['bus_cover_image']}';
        });
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
      appBar: AppBar(
        backgroundColor:  Color(0xFF937047),
        title: Text('Profile'),
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
                SizedBox(height: 10),
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
                          'Edit Profile',
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
                //Image Picker Button
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
                                    return bus_dp_url == " " ? const Icon(
                                        Icons.account_circle, size: 110, color: Color(0xFFe7dac7)) :
                                    CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(borderRadius: BorderRadius.circular(100),child:
                                      Image.network(bus_dp_url, height: 100, width: 100, fit: BoxFit.fill,),),
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
                SizedBox(height: 10),
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
                          'Edit Cover',
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
                //Cover Image
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        width: 300,
                      color: Color(0xFF937047),
                      child: Container(
                          child:  _photo_cover != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              _photo_cover!,
                              width: 300,
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                              : Container(
                            child:  Expanded(
                              child: FutureBuilder(
                                future: getUserProfilePicture(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return get_bus_cover_url == " " ? const Icon(
                                        Icons.account_circle, size: 300, color: Color(0xFFe7dac7)) :
                                    Container(

                                      child: ClipRRect(borderRadius: BorderRadius.circular(15),child:
                                      Image.network(get_bus_cover_url, height: 150, width: 300, fit: BoxFit.fill,),),
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
                            _showPickerCover(context);
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
                SizedBox(height: 10),
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
                          'Edit Details',
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
                //Bus details
                Container(
                  height: 1350,
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20), topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.black12,
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FutureBuilder(
                            future: getBus(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                itemCount: docids.length.sign,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: EditBusDetails(documentId: docids[index],),
                                  );
                                },);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //Bus Dp Image Picker Funtion
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

  //Bus Cover Image Picker Function
  void _showPickerCover(context) {
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
                        imgFromGalleryCover();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCameraCover();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
