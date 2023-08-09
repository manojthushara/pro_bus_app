import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerPage extends StatefulWidget {
  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}
final user = FirebaseAuth.instance.currentUser!;
class _QRScannerPageState extends State<QRScannerPage> {
  String get_qr = " ";

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = '';

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

//QR Scanner funtion
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code!;
      });
    });
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('buses');

  bool isDataPresent = false;


  @override
  void initState() {
    super.initState();
    checkDataInArray();
  }

  //Check Ticket
  Future<void> checkDataInArray() async {
    final QuerySnapshot snapshot = await usersCollection.where('email', isEqualTo: user?.email).get();

    snapshot.docs.forEach((doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final List<dynamic> dataArray = data['book_sheet'];

      if (dataArray.contains(qrText)) {
        setState(() {
          isDataPresent = true;
        });
      }
    });
  }

  //Mark Ticket
  Future<void> deleteDataInArray() async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('buses');
    QuerySnapshot querySnapshot = await collectionRef.where('email', isEqualTo: user?.email).get();
    DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
    DocumentReference documentRef = documentSnapshot.reference;

    documentRef.update({
      'book_sheet': FieldValue.arrayRemove([qrText]),
    })
        .then((value) {
      print('Value removed successfully');
    })
        .catchError((error) {
      print('Failed to remove value: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xFF937047),
      ),
      backgroundColor: Color(0xFFe7dac7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
                    "QR Scanner",
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

          //Scanner
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),

          //Scanner text
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scanned QR Code: $qrText',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
          ),

          //check Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF937047),
              minimumSize: Size(300, 50),
            ),
            onPressed: checkDataInArray,
            child: Text('Check Ticket',style: TextStyle(fontSize: 18),),
          ),

          SizedBox(height: 20,),

          //Scanner result
          Center(
            child: isDataPresent
                ? Text('Open Gate',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                : Text('Close Gate.'),
          ),

          SizedBox(height: 20,),

          //Mark Ticket
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF937047),
              minimumSize: Size(300, 50),
            ),
            onPressed: () {
              deleteDataInArray();
              Navigator.pop(context);
            },
            child: Text('Mark Ticket',style: TextStyle(fontSize: 18),),
          ),

          SizedBox(height: 20,),

          //Cancel Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF937047),
              minimumSize: Size(300, 50),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel',style: TextStyle(fontSize: 18),),
          ),

          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
