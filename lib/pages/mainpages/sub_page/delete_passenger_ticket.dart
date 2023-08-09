import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../first_pages/navigator_bar.dart';
import '../../../profile page tab/profiles_bar.dart';

class DeleteUserTicket extends StatefulWidget {
  String getsheet;
  String get_bus_no;
  DeleteUserTicket ({required this.getsheet,required this.get_bus_no});


  @override
  State<DeleteUserTicket> createState() => _DeleteUserTicketState();
}

class _DeleteUserTicketState extends State<DeleteUserTicket> {
  GlobalKey globalKey = GlobalKey();

  String getqr = " ";
  final user = FirebaseAuth.instance.currentUser!;
  String getticket = " ";
  String getfrom = " ";
  String getto = " ";
  String get_bus_no = " ";

  //get firebase details
  Future getBusRoot() async {
    await FirebaseFirestore.instance
        .collection('passengers')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((documentw) {
        setState(() async {
          getticket = '${documentw['sheet_no']}';
          getfrom = '${documentw['form']}';
          getto = '${documentw['to']}';
          get_bus_no = '${documentw['bus_no']}';

        });
      }),
    );
  }


  void deleteField() async {

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('passengers')
        .where('email', isEqualTo: user?.email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = querySnapshot.docs.first;

      DocumentReference documentRef = documentSnapshot.reference;

      await documentRef.update({
        'sheet_no': FieldValue.delete(),
        'form': FieldValue.delete(),
        'to': FieldValue.delete(),
        'bus_on': FieldValue.delete()
      });
      showErrorMessage('Deleted');

    }
  }

  Future<void> deleteBusTicket() async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('buses');
    QuerySnapshot querySnapshot = await collectionRef.where('bus_no', isEqualTo: widget.get_bus_no).get();
    DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
    DocumentReference documentRef = documentSnapshot.reference;

    documentRef.update({
      'book_sheet': FieldValue.arrayRemove([widget.getsheet]),
    })
        .then((value) {
      print('Value removed successfully');
    })
        .catchError((error) {
      print('Failed to remove value: $error');
    });
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
                        "Delete Ticket",
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
                height: 450,
                width: 250,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("Bus Ticket",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),

                    Container(
                      height: 200,
                      width: 200,
                      color: Colors.white,
                      child: RepaintBoundary(
                        key: globalKey,
                        child: QrImage(
                          backgroundColor: Colors.white,
                          data: 'probus 00'+widget.getsheet+'1998',
                          version: QrVersions.auto,
                          size: 100.0,

                        ),
                      ),
                    ),

                    Text('Booking No: probus 00'+ widget.getsheet +'1998',style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),),

                    FutureBuilder(
                        future: getBusRoot(),
                        builder: (context, snapshot){
                          if (snapshot.connectionState ==
                              ConnectionState.done){
                            return Column(
                              children: [
                                SizedBox(height: 20,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(getfrom,style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        Text('to',style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        Text(getto,style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        SizedBox(height: 10,),
                                        Text(get_bus_no,style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Text('Sheet No: '+widget.getsheet,style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                              ],
                            );
                          }
                          return Container();
                        }
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40,),

              GestureDetector(
                onTap: () {
                  deleteField();
                  deleteBusTicket();
                  setState(() {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilesBar()),
                            (Route<dynamic> route) => false);
                  });
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
                      "DELETE",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),

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
