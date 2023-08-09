import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/components/booked_sheet.dart';

import '../../../../components/sheet_button.dart';
import 'booking_page.dart';

class TripleSheetPage extends StatelessWidget {
  String documnetID;
  TripleSheetPage ({required this.documnetID,});
  String sheet1 = '01';
  String sheet2 = '02';
  String sheet3 = '03';
  String sheet4 = '04';
  String sheet5 = '05';
  String sheet6 = '06';
  String sheet7 = '07';
  String sheet8 = '08';
  String sheet9 = '09';
  String sheet10 = '10';
  String sheet11 = '11';
  String sheet12 = '12';
  String sheet13 = '13';
  String sheet14 = '14';
  String sheet15 = '15';
  String sheet16 = '16';
  String sheet17 = '17';
  String sheet18 = '18';
  String sheet19 = '19';
  String sheet20 = '20';
  String sheet21 = '21';
  String sheet22 = '22';
  String sheet23 = '23';
  String sheet24 = '24';
  String sheet25 = '25';
  String sheet26 = '26';
  String sheet27 = '27';
  String sheet28 = '28';
  String sheet29 = '29';
  String sheet30 = '30';
  String sheet31 = '31';
  String sheet32 = '32';
  String sheet33 = '33';
  String sheet34 = '34';
  String sheet35 = '35';
  String sheet36 = '36';
  String sheet37 = '37';
  String sheet38 = '38';
  String sheet39 = '39';
  String sheet40 = '40';
  String sheet41 = '41';
  String sheet42 = '42';
  String sheet43 = '43';
  String sheet44 = '44';
  String sheet45 = '45';
  String sheet46 = '46';
  String sheet47 = '47';
  String sheet48 = '48';
  String sheet49 = '49';
  String sheet50 = '50';
  String sheet51 = '51';
  String sheet52 = '52';
  String sheet53 = '53';
  String sheet54 = '54';
  String sheet55 = '55';
  String sheet56 = '56';
  String sheet57 = '57';
  String sheet58 = '58';
  String sheet59 = '59';
  String sheet60 = '60';
  String sheet61 = '61';
  String sheet62 = '62';
  String sheet63 = '63';
  String sheet64 = '64';

  @override
  Widget build(BuildContext context) {

    CollectionReference buses = FirebaseFirestore.instance.collection('buses');
    List<Offset> pointlist = <Offset>[];
    return FutureBuilder(
        future: buses.doc(documnetID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

              List<dynamic> pointlist = List.from(data['book_sheet']);

            return  Container(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('01')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet1)),
                                    );},
                                    text: '01',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('02')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet2))
                                    );},
                                    text: '02',
                                  );
                                }),
                            SizedBox(width: 51,),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('03')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '03',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet3)),
                                    );},
                                    text: '03',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('04')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '03',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet4)),
                                    );},
                                    text: '04',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('04')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet5)),
                                    );},
                                    text: '05',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){

                                  if ( pointlist.contains('06')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '06',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet6)),
                                    );},
                                    text: '06',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('07')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet7))
                                    );},
                                    text: '07',
                                  );
                                }),
                            SizedBox(width: 51,),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('08')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet8)),
                                    );},
                                    text: '08',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('09')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet9)),
                                    );},
                                    text: '09',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('10')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet10)),
                                    );},
                                    text: '10',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('11')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet11)),
                                    );},
                                    text: '11',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('12')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet12))
                                    );},
                                    text: '12',
                                  );
                                }),
                            SizedBox(width: 51,),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('13')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet13)),
                                    );},
                                    text: '13',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('14')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet14)),
                                    );},
                                    text: '14',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('15')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet15)),
                                    );},
                                    text: '15',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('16')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet16)),
                                    );},
                                    text: '16',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('17')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet17))
                                    );},
                                    text: '17',
                                  );
                                }),
                            SizedBox(width: 51,),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('18')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet18)),
                                    );},
                                    text: '18',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('19')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet19)),
                                    );},
                                    text: '19',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('20')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet20)),
                                    );},
                                    text: '20',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('21')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet21)),
                                    );},
                                    text: '21',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('22')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet22))
                                    );},
                                    text: '22',
                                  );
                                }),
                            SizedBox(width: 51,),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('23')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet23)),
                                    );},
                                    text: '23',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('24')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet24)),
                                    );},
                                    text: '24',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('25')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet25)),
                                    );},
                                    text: '25',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('26')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet26)),
                                    );},
                                    text: '26',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('27')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet27))
                                    );},
                                    text: '27',
                                  );
                                }),
                            SizedBox(width: 51,),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('28')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet28)),
                                    );},
                                    text: '28',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('29')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet29)),
                                    );},
                                    text: '29',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('30')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet30)),
                                    );},
                                    text: '30',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('31')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet31)),
                                    );},
                                    text: '31',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('32')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet32))
                                    );},
                                    text: '32',
                                  );
                                }),
                            SizedBox(width: 51,),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('33')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet33)),
                                    );},
                                    text: '34',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('35')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet34)),
                                    );},
                                    text: '35',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('35')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet35)),
                                    );},
                                    text: '35',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('36')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet36)),
                                    );},
                                    text: '36',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('37')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet37))
                                    );},
                                    text: '37',
                                  );
                                }),
                            SizedBox(width: 51,),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('38')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet38)),
                                    );},
                                    text: '38',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('39')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet39)),
                                    );},
                                    text: '39',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('40')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet40)),
                                    );},
                                    text: '40',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('41')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet41)),
                                    );},
                                    text: '41',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('42')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet42))
                                    );},
                                    text: '42',
                                  );
                                }),
                            SizedBox(width: 51,),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('43')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet43)),
                                    );},
                                    text: '43',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('44')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet44)),
                                    );},
                                    text: '44',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('45')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet45)),
                                    );},
                                    text: '45',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('46')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet46)),
                                    );},
                                    text: '46',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('47')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet47))
                                    );},
                                    text: '47',
                                  );
                                }),
                            SizedBox(width: 51,),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('48')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet48)),
                                    );},
                                    text: '48',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('49')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet49)),
                                    );},
                                    text: '49',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('50')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet50)),
                                    );},
                                    text: '50',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('51')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet51)),
                                    );},
                                    text: '51',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('52')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '01',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet52))
                                    );},
                                    text: '52',
                                  );
                                }),
                            SizedBox(width: 51,),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('53')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet53)),
                                    );},
                                    text: '53',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('54')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet54)),
                                    );},
                                    text: '54',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('55')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet55)),
                                    );},
                                    text: '55',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(width: 100,),
                            SizedBox(width: 51,),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('56')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet56)),
                                    );},
                                    text: '56',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('57')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet57)),
                                    );},
                                    text: '57',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('58')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet58)),
                                    );},
                                    text: '58',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,left: 25),
                      child: Center(
                        child: Row(
                          children: [
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('59')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet59)),
                                    );},
                                    text: '59',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('60')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet60)),
                                    );},
                                    text: '60',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('61')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet61)),
                                    );},
                                    text: '61',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('62')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet62)),
                                    );},
                                    text: '62',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('63')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet63)),
                                    );},
                                    text: '63',
                                  );
                                }),
                            FutureBuilder(
                                future: buses.doc(documnetID).get(),
                                builder: (context, snapshot){
                                  if ( pointlist.contains('64')){
                                    return BookSheet(
                                      onTop: () {},
                                      text: '04',
                                    );
                                  }
                                  return SheetButton(
                                    onTop: () {Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet64)),
                                    );},
                                    text: '64',
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    ],
                  ),
                ),
              );
            }
          return Container();
          }
        )
    );
  }
}
