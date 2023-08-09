import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/home_page.dart';

class BookListPage extends StatefulWidget {


  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {

  final user = FirebaseAuth.instance.currentUser!;
  List<dynamic> pointlist = [];

  Future getsheetnumbers() async {

    await FirebaseFirestore.instance
        .collection('buses')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {

        pointlist = document.get('book_sheet');
      }),
    );
  }

  Future<void> deleteBusTicket(String number) async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('buses');
    QuerySnapshot querySnapshot = await collectionRef.where('email', isEqualTo: user?.email).get();
    DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
    DocumentReference documentRef = documentSnapshot.reference;

    documentRef.update({
      'book_sheet': FieldValue.arrayRemove([number]),
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
        backgroundColor: Color(0xFF937047),
        title: Text('Home'),
      ),
      backgroundColor: Color(0xFFe7dac7),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    height: 150,
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset('lib/images/book_sheet.png',width: 100,height: 100,),
                      )),
                  SizedBox(height: 5,),
                  Center(
                    child: SizedBox(
                      height: 600.0,
                      child: Expanded(
                        child: FutureBuilder(
                          future: getsheetnumbers(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                                itemCount: pointlist.length,
                                itemBuilder: (context, index)
                                { if (pointlist[index] == ' '){
                                  return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                        ),
                                      ));
                                }
                                return ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                        height: 85,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          color: Colors.black12,
                                        ),
                                        child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset('lib/images/book.png',height: 80,),
                                                Text('Seat No:',style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19
                                                ),),
                                                Text(pointlist[index],style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19,
                                                    color: Colors.white
                                                ),),
                                                Text(' Booked',style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19
                                                ),),
                                                GestureDetector(
                                                  onTap: (){
                                                    deleteBusTicket(pointlist[index]);
                                                    setState(() {

                                                    });
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.only(right: 20,left: 20),
                                                    child: CircleAvatar(
                                                        backgroundColor: Color(0xFF937047),
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: Colors.white,)
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ))),
                                  ),
                                );
                                }
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
