
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../../../first_pages/navigator_bar.dart';



class QR_Pge extends StatefulWidget {
  String dropDownValue;
  QR_Pge ({required this.dropDownValue});

  @override
  State<QR_Pge> createState() => _QR_PgeState();
}

class _QR_PgeState extends State<QR_Pge> {

  GlobalKey globalKey = GlobalKey();
  final user = FirebaseAuth.instance.currentUser!;

  //Download QR Function
  Future<void> saveQRCode() async {
    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      await ImageGallerySaver.saveImage(pngBytes, quality: 100);
      print('QR code downloaded successfully.');
      showErrorMessage('QR code downloaded successfully.');

    } catch (e) {
      print('Failed to download the QR code: $e');
      showErrorMessage('Failed to download the QR code: $e');
    }
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
      appBar: AppBar(
        title: Text('Payment Option'),
        backgroundColor: Color(0xFF937047),
      ),
      backgroundColor: Color(0xFFe7dac7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Text(
                      "QR Code",
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

            SizedBox(height: 20,),

             //Icon Image
             Image.asset('lib/images/qr_icon.png',width: 150,height: 150,),

            SizedBox(height: 20,),

            //QR Generator
            Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        backgroundColor: Colors.white,
                        data: widget.dropDownValue,
                        version: QrVersions.auto,
                        size: 280.0,

                      ),
                    ),
                    SizedBox(height: 5,),
                    Text('Booking No: probus 00'+widget.dropDownValue+'1998',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.0),

            //Download QR Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF937047),
                minimumSize: Size(300, 50),
              ),
              onPressed: saveQRCode,
              child: Text('Download QR Code',style: TextStyle(fontSize: 18)),
            ),

            SizedBox(height: 20,),

            //Cancel Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF937047),
                minimumSize: Size(300, 50),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationPage()),
                        (Route<dynamic> route) => false);
              },
              child: Text('Cancel',style: TextStyle(fontSize: 18),),
            ),

            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
