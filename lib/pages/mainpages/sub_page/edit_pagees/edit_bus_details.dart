
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/components/my_textfield_01.dart';


class EditBusDetails extends StatefulWidget {
  final String documentId;
  final user = FirebaseAuth.instance.currentUser!;

  EditBusDetails({required this.documentId});

  @override
  State<EditBusDetails> createState() => _EditBusDetailsState();
}

class _EditBusDetailsState extends State<EditBusDetails> {
  final busNoController = TextEditingController();
  final busNameController = TextEditingController();
  final busContactController = TextEditingController();
  final busOwnerController = TextEditingController();
  final busAddressController = TextEditingController();
  final busRegisterNoController = TextEditingController();
  final busRootController = TextEditingController();
  final busRootNoController = TextEditingController();
  final driverNameController = TextEditingController();
  final driverContactController = TextEditingController();
  final driverLicenceNoController = TextEditingController();
  final conductornameController = TextEditingController();
  final conductorConctactController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void disponse() {
    busNoController.dispose();
    busNameController.dispose();
    busContactController.dispose();
    busOwnerController.dispose();
    busAddressController.dispose();
    busRegisterNoController.dispose();
    busRootController.dispose();
    busRootNoController.dispose();
    driverNameController.dispose();
    driverContactController.dispose();
    driverLicenceNoController.dispose();
    conductornameController.dispose();
    conductorConctactController.dispose();
    super.dispose();
  }

  //Update Details Button
  void update() async {
    updateUserDetails(
      busNoController.text.trim(),
        busNameController.text.trim(),
      int.parse(busContactController.text.trim()),
      busOwnerController.text.trim(),
      busAddressController.text.trim(),
      busRegisterNoController.text.trim(),
      busRootController.text.trim(),
      int.parse(busRootNoController.text.trim()),
    );
  }

  Future updateUserDetails(
      String busNo,
      String busname,
      int busContact,
      String busOwner,
      String busAddress,
      String busRegisterNo,
      String busRoot,
      int busRootNo,

      ) async {
    await FirebaseFirestore.instance.collection('buses').where('email', isEqualTo: user?.email).get().then(
          (snapshot) => snapshot.docs.forEach((document) {

        try{
          FirebaseFirestore.instance.collection('buses').doc(document.id).update(
              {
                'bus_no': busNo,
                'bus_name': busname,
                'bus_contact': busContact,
                'bus_owner': busOwner,
                'bus_address': busAddress,
                'bus_register_no': busRegisterNo,
                'bus_root': busRoot,
                'bus_root_no': busRootNo,

              }
          );
          Navigator.pop(context);
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

    CollectionReference users = FirebaseFirestore.instance.collection('buses');

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
                            SizedBox(height: 20,),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Bus Name --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),

                            SizedBox(height: 5,),

                            MyTextField01(
                              controller: busNameController..text = '${data['bus_name']}' ,
                              hintText: '',
                              obscureText: false, initialValue: '${data['bus_name']}',),

                            SizedBox(height: 10,),

                            //BusNo
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Bus No --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),

                            SizedBox(height: 5,),

                            MyTextField01(
                              controller: busNoController..text = '${data['bus_no']}' ,
                              hintText: '',
                              obscureText: false, initialValue: '${data['bus-no']}',),

                            SizedBox(height: 10,),
                            //BusContact
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Bus Contact --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: busContactController..text = '${data['bus_contact']}',
                                initialValue: '${data['bus_contact']}',
                                hintText: '',
                                obscureText: false),
                            SizedBox(height: 10,),
                            //BusOwner
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Bus Owner --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: busOwnerController..text = '${data['bus_owner']}',
                                initialValue: '${data['bus_owner']}',
                                hintText: '',
                                obscureText: false),
                            SizedBox(height: 10,),
                            //BusAddress
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Bus Address --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: busAddressController..text = '${data['bus_address']}',
                                initialValue: '${data['bus_address']}',
                                hintText: '',
                                obscureText: false),
                            SizedBox(height: 10,),
                            //BusRegisterNumber
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Bus Register NO --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: busRegisterNoController..text = '${data['bus_register_no']}',
                                initialValue: '${data['bus_register_no']}',
                                hintText: '',
                                obscureText: false),
                            SizedBox(height: 10,),
                            //BusRoot
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Bus Root --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: busRootController..text = '${data['bus_root']}',
                                initialValue: '${data['bus_root']}',
                                hintText: '',
                                obscureText: false),
                            SizedBox(height: 10,),
                            //BusRootNo
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Bus Root No --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: busRootNoController..text = '${data['bus_root_no']}',
                                initialValue: '${data['contact']}',
                                hintText: '',
                                obscureText: false),
                            SizedBox(height: 10,),

                            //DriverName
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Driver Name --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: driverNameController..text = '${data['driver_name']}',
                                initialValue: '${data['driver_name']}',
                                hintText: '',
                                obscureText: false),
                            SizedBox(height: 10,),
                            //DriverContact
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Driver Contact --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: driverContactController..text = '${data['driver_contact']}',
                                initialValue: '${data['driver_contact']}',
                                hintText: '',
                                obscureText: false),
                            SizedBox(height: 10,),
                            //DriverLicens
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Driver  Licence--", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: driverLicenceNoController..text = '${data['driver_licence_no']}',
                                initialValue: '${data['driver_licence_no']}',
                                hintText: '',
                                obscureText: false),
                            SizedBox(height: 10,),
                            //DriverName
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Conductor Name --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: conductornameController..text = '${data['conductor_name']}',
                                initialValue: '${data['conductor_name']}',
                                hintText: '',
                                obscureText: false),
                            SizedBox(height: 10,),
                            //Conductorcontat
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "-- Conductor Contact --", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            MyTextField01(
                                controller: driverContactController..text = '${data['conductor_contact']}',
                                initialValue: '${data['conductor_contact']}',
                                hintText: '',
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
