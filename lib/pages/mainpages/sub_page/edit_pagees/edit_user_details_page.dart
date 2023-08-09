
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/components/my_textfield_01.dart';


class EditUserDetailsPage extends StatefulWidget {
  final String documentId;
  final user = FirebaseAuth.instance.currentUser!;



  EditUserDetailsPage({required this.documentId});

  @override
  State<EditUserDetailsPage> createState() => _EditUserDetailsPageState();
}

class _EditUserDetailsPageState extends State<EditUserDetailsPage> {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void disponse() {
    nameController.dispose();
    super.dispose();
  }

  //Update Details Button
  void update() async {
    updateUserDetails(
        nameController.text.trim(),
        int.parse(contactController.text.trim())
    );
  }

  Future updateUserDetails(String name, int contact) async {
    await FirebaseFirestore.instance.collection('passengers').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((document) {

        try{
          FirebaseFirestore.instance.collection('passengers').doc(document.id).update(
              {
                'name': name,
                'contact': contact,
              }
              );
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Color(0xFFe7dac7),
                alignment: Alignment.center ,
                title: Center(
                  child: Text(
                    'Your data is Updated',
                    style: const TextStyle(color: Color(0xFF241f1c)),
                  ),
                ),
              );
            },
          );
          setState(() {

          });
          Navigator.pop(context);

        } on FirebaseAuthException catch (e) {
          // pop the loading circle
          Navigator.pop(context);
          // show error message
          showErrorMessage(e.code);
        }
      }),
    );
  }
  //show error massage
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

    CollectionReference users = FirebaseFirestore.instance.collection('passengers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Name --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: nameController..text = '${data['name']}' ,
                                hintText: 'Name: '+'${data['name']}',
                                obscureText: false, initialValue: '${data['name']}',),
                            SizedBox(height: 10,),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Contact --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: contactController..text = '${data['contact']}',
                                initialValue: '${data['contact']}',
                                hintText: 'Contact: '+'${data['contact']}',
                                obscureText: false),
                            SizedBox(height: 10,),
                            GestureDetector(
                          onTap: update,
                              child: Container(
                              padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 25),
                                  decoration: BoxDecoration(
                              color: Color(0xFF937047),
                        borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "UPDATE",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Center(child: CircularProgressIndicator(color: Colors.black,));
      }),
    );
  }
}
