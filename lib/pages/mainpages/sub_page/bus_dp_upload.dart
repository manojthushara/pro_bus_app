import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class BusDpUploadPage extends StatefulWidget {

  const BusDpUploadPage({Key? key }) : super(key: key);

  @override
  State<BusDpUploadPage> createState() => _BusDpUploadPageState();
}

class _BusDpUploadPageState extends State<BusDpUploadPage> {
  final user = FirebaseAuth.instance.currentUser!;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();
  String imageurl = " ";
  String getname = " ";

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

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = '$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref('profile_image/').child(destination);
      await ref.putFile(_photo!);
      var url = await ref.getDownloadURL();
      print(url);
      addUserDetails(url);
    } catch (e) {
      print('error occured');
    }
  }

  Future addUserDetails(String image) async {
    await FirebaseFirestore.instance.collection('passengers').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        try{
          FirebaseFirestore.instance.collection('passengers').doc(document.id).update({'image': image});
        } catch (e){
          print('filed');
        }
      }),
    );
  }

//profile pictur
  Future getUserProfilePicture() async {
    await FirebaseFirestore.instance.collection('passengers').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((documentw) {

        setState(() async {
          imageurl = '${documentw['image']}';
          getname = '${documentw['name']}';
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              ],
            ),
          ),
        ),

    );
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
}
