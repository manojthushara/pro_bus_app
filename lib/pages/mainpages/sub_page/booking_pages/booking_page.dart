
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/booking_pages/payment.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/qr_pages/qr_genarate.dart';

import '../../../../services/payment_config.dart';

class BookingPage extends StatefulWidget {
  String documnetID;
  String sheet1;
  BookingPage ({required this.documnetID,required this.sheet1});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  String  _dropDownValuefrom = "Select From";
  String _dropDownValueto = "Select To";
  String _price = 'No Ticket for this direction';
  String bus_no = ' ';
  final user = FirebaseAuth.instance.currentUser!;



  @override
  void disponse() {
    widget.sheet1;
    _dropDownValuefrom;
    _dropDownValueto;
    bus_no;
    super.dispose();
  }

  //time to firebase
  void addsheetuser() async {
    adduserticket(
      widget.sheet1,
      _dropDownValuefrom,
      _dropDownValueto,
        bus_no,
    );
  }

  Future adduserticket(
      String booksheet,
      String form,
      String to,
      String bus,

      ) async {
    await FirebaseFirestore.instance
        .collection('passengers')
        .where('email', isEqualTo: user?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
        try {
          FirebaseFirestore.instance
              .collection('passengers')
              .doc(document.id)
              .update({
            'sheet_no': booksheet,
            'form' : form,
            'to' : to,
            'bus_no' : bus,

          });

        } on FirebaseAuthException catch (e) {}
      }),
    );
  }

  //time to firebase
  void addsheetbus() async {
    add(
      widget.sheet1,
    );
  }

  Future add(
      String nosheet,

      ) async {

    await FirebaseFirestore.instance
        .collection('buses').doc(widget.documnetID)
        .update({
      'book_sheet': FieldValue.arrayUnion([widget.sheet1,])});
  }

  //Google Button
  var googlePayButton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
    paymentItems:  [
      PaymentItem(
        label: 'Total',
        amount: '0.01',
        status: PaymentItemStatus.final_price,)
    ],
    width: double.infinity,
    type: GooglePayButtonType.pay,
    onPaymentResult: (result) => debugPrint('Payment Result $result'),
    loadingIndicator: const Center(child: CircularProgressIndicator(),),
  );


  @override
  Widget build(BuildContext context) {

    CollectionReference buses = FirebaseFirestore.instance.collection('buses');

    return FutureBuilder(
        future: buses.doc(widget.documnetID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

            bus_no = '${data['bus_no']}';

            return  Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xFF937047),
                  title: Text('Sheet Selection'),
                ),
                backgroundColor: Color(0xFFe7dac7),
                body: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                          children: [

                            SizedBox(height: 10,),

                            //heading
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
                                      "Booking Sheet",
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

                            SizedBox(height: 10,),

                            Container(
                              height: 650,
                              width: 340,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                color: Colors.black12,
                              ),
                              child: Column(
                                children: [

                                  SizedBox(height: 30,),

                                  //Icon Image
                                  Image.asset('lib/images/onlinepyment.png',width: 150,height: 150,),

                                  SizedBox(height: 10,),

                                  Text('Form:',style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18
                                  ),),

                                  //from
                                  Padding(
                                    padding: const EdgeInsets.only(right: 70, left: 70, top: 5, bottom: 5),
                                    child: Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton(
                                          dropdownColor: Color(0xFFe7dac7),
                                          // ignore: unnecessary_null_comparison
                                          hint: _dropDownValuefrom == null
                                              ? Text('Dropdown',style: TextStyle(color: Colors.black,fontSize: 15),)
                                              : Text(_dropDownValuefrom, style: TextStyle(color: Colors.black,fontSize: 15),),

                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(color: Colors.black),
                                          items: ['Panadura','Moratuwa','Ratmalana','MT Lavinia','Dehiwala','Nugegoda','Battaramulla','Malabe',
                                            'Kaduwela','Biyagama','Balum Mahara','Nittabuwa','Warakapola','Kegalle','Mawanella','Kadugannawa','Peradeniya','Kandy'].map(
                                                (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            setState(
                                                  () {
                                                _dropDownValuefrom = val.toString();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 10,),

                                  Text('To: ',style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18
                                  ),),

                                  //to
                                  Padding(
                                    padding: const EdgeInsets.only(right: 70, left: 70, top: 5, bottom: 5),
                                    child: Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton(
                                          dropdownColor: Color(0xFFe7dac7),
                                          // ignore: unnecessary_null_comparison
                                          hint: _dropDownValueto == null
                                              ? Text('Dropdown',style: TextStyle(color: Colors.black,fontSize: 15),)
                                              : Text(_dropDownValueto, style: TextStyle(color: Colors.black,fontSize: 15),),

                                          isExpanded: true,
                                          iconSize: 30.0,
                                          style: TextStyle(color: Colors.black),
                                          items: ['Panadura','Moratuwa','Ratmalana','MT Lavinia','Dehiwala','Nugegoda','Battaramulla','Malabe',
                                            'Kaduwela','Biyagama','Balum Mahara','Nittabuwa','Warakapola','Kegalle','Mawanella','Kadugannawa','Peradeniya','Kandy'].map(
                                                (val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (val) {
                                            setState(
                                                  () {
                                                _dropDownValueto = val.toString();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 10,),

                                  //calculate
                                  FutureBuilder(
                                    future: buses.doc(widget.documnetID).get(),
                                      builder: (context, snapshot){
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Panadura')
                                        ){
                                          return Text('Rs:522/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Moratuwa')
                                        ){
                                          return Text('Rs:497/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Ratmalana')
                                        ){
                                          return Text('Rs:491/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'MT Lavinia')
                                        ){
                                          return Text('Rs:484/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Dehiwala')
                                        ){
                                          return Text('Rs:471/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Nugegoda')
                                        ){
                                          return Text('Rs:452/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Battaramulla')
                                        ){
                                          return Text('Rs:434/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Malabe')
                                        ){
                                          return Text('Rs:421/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Kaduwela')
                                        ){
                                          return Text('Rs:403/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Biyagama')
                                        ){
                                          return Text('Rs:388/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Balum Mahara')
                                        ){
                                          return Text('Rs:349/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Nittabuwa')
                                        ){
                                          return Text('Rs:305/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Warakapola')
                                        ){
                                          return Text('Rs:245/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Kegalle')
                                        ){
                                          return Text('Rs:175/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Mawanella')
                                        ){
                                          return Text('Rs:131/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Kadugannawa')
                                        ){
                                          return Text('Rs:96/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Kandy') && (_dropDownValueto == 'Peradeniya')
                                        ){
                                          return Text('Rs:48/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Peradeniya')
                                        ){
                                          return Text('Rs:504/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Kadugannawa')
                                        ){
                                          return Text('Rs:471/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Mawanella')
                                        ){
                                          return Text('Rs:440/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Kegalle')
                                        ){
                                          return Text('Rs:395/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Warakapola')
                                        ){
                                          return Text('Rs:318/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Nittabuwa')
                                        ){
                                          return Text('Rs:267/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Balum Mahara')
                                        ){
                                          return Text('Rs:221/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Biyagama')
                                        ){
                                          return Text('Rs:182/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Kaduwela')
                                        ){
                                          return Text('Rs:169/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Malabe')
                                        ){
                                          return Text('Rs:149/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Battaramulla')
                                        ){
                                          return Text('Rs:138/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Nugegoda')
                                        ){
                                          return Text('Rs:118/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Dehiwala')
                                        ){
                                          return Text('Rs:96/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'MT Lavinia')
                                        ){
                                          return Text('Rs:92/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Rathmalana')
                                        ){
                                          return Text('Rs:81/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }
                                        if ((_dropDownValuefrom == 'Panadura') && (_dropDownValueto == 'Moratuwa')
                                        ){
                                          return Text('Rs:59/=',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25
                                          ),);
                                        }


                                        return Text(_price,style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20
                                        ));
                                      }),

                                  SizedBox(height: 10,),

                                  SizedBox(height: 10,),

                                  //process button
                                  GestureDetector(
                                        onTap: (){
                                          if(
                                          (_dropDownValuefrom == 'Select From') || (_dropDownValueto == 'Select To')
                                          ) {
                                          }else{
                                            addsheetbus();
                                            addsheetuser();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>  PaymentPage(dropDownValue: widget.sheet1)),
                                            );
                                          }
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
                                            "PROCESS",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  SizedBox(height: 30,),

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
                          ]
                      ),
                    ),
                  ),
                )
            );
          }
          //Loading
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF937047),
          title: Text('Sheet Selection'),
          ),
            body:  Container(
              color: Color(0xFFe7dac7),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        )
    );
  }
}
