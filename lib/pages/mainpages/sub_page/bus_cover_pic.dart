import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class BusCoverPic extends StatefulWidget {
  const BusCoverPic({Key? key}) : super(key: key);

  @override
  State<BusCoverPic> createState() => _BusCoverPicState();
}

class _BusCoverPicState extends State<BusCoverPic> {
  final user = FirebaseAuth.instance.currentUser!;

  String imageurl = " ";
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
    await FirebaseFirestore.instance.collection('buses').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        try{
          FirebaseFirestore.instance.collection('buses').doc(document.id).update({'bus_cover_image': image});
        } catch (e){
          print('filed');
        }
      }),
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

  Future getUserProfilePicture() async {
    await FirebaseFirestore.instance.collection('passengers').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((documentw) {

        setState(() async {
          imageurl = '${documentw['bus_cover']}';
        });
      }),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20), topLeft: Radius.circular(20),
            topRight: Radius.circular(20)),
        color: Color(0xFF937047),
      ),
      child: Center(
        child: Stack(
          children: [
            Container(
              child: Container(
                height: 140,
                width: 290,
                color: Color(0xFF937047),
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
                      future: getUserProfilePicture(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return imageurl == " " ? const Icon(
                              Icons.add_photo_alternate_outlined, size: 50, color: Color(0xFFe7dac7)) :
                          Container(
                            height: 150,
                            width: 300,
                            child: ClipRRect(borderRadius: BorderRadius.circular(15),child:
                            Image.network(imageurl, height: 150, width: 300, fit: BoxFit.fill,),),
                          );
                        }return Center(child: CircularProgressIndicator(color: Colors.black,));
                      },
                    ),
                  ),
                ),

              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
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
    );
  }
}
