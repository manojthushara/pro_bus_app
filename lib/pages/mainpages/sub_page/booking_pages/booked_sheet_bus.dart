import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookedSheetBusPage extends StatelessWidget {
  final String documentId;

  BookedSheetBusPage({required this.documentId});

  @override
  Widget build(BuildContext context) {

    CollectionReference buses = FirebaseFirestore.instance.collection('buses');

    return FutureBuilder<DocumentSnapshot>(
      future: buses.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return Stack(
            children: [
              Container(

                width: 100,
                height: 100,
                color: Colors.white,
                child: Text('view'),
              )
            ],
          );
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            color: Color(0xFFe7dac7),
          ),
          height: 100,
        );
      }
      ),
    );
  }
}
