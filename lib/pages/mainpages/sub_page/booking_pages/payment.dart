import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/qr_pages/qr_genarate.dart';
import 'package:pro_bus_app/services/payment_config.dart';

class PaymentPage extends StatelessWidget {
  String dropDownValue;
  PaymentPage ({required this.dropDownValue});

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Process'),
        backgroundColor:  Color(0xFF937047),
      ),
      backgroundColor: Color(0xFFe7dac7),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                      "Payment Option",
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

            SizedBox(height: 100,),

            //icon image
            Image.asset('lib/images/payment_method.png',width: 200,height: 200,),

            SizedBox(height: 200,),

            //Google pay button
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Center(child: googlePayButton),
              ),
            ),

            SizedBox(height: 20,),

            //Generate QR code option button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  QR_Pge(dropDownValue: dropDownValue)),
                );
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
                    "QR CODE",
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

            //Cancel Button
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
    );
  }
}
