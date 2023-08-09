import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRcodeViewUser extends StatelessWidget {
  String getsheet;
  QRcodeViewUser ({required this.getsheet});

  GlobalKey globalKey = GlobalKey();

  String getqr = " ";

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF937047),
        title: Text('Activity'),
      ),
      backgroundColor: Color(0xFFe7dac7),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Text(
                          "QR Code",
                          style: TextStyle(
                            color: Color(0xFF241f1c),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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

                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    height: 350,
                    width: 350,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 300,
                          width: 300,
                          color: Colors.white,
                          child: RepaintBoundary(
                            key: globalKey,
                            child: QrImage(
                              backgroundColor: Colors.white,
                              data: 'probus 00'+getsheet+'1998',
                              version: QrVersions.auto,
                              size: 100.0,

                            ),
                          ),
                        ),
                        Text('Booking No: probus 00'+ getsheet +'1998',style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                ),

                SizedBox(height: 40,),

                //cancel button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                    decoration: BoxDecoration(
                      color: Color(0xFF937047),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "CANCEL",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
