import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../components/booked_sheet.dart';
import '../../../../components/sheet_button.dart';
import 'booking_page.dart';

class DoubleSheetPage extends StatelessWidget {
  String documnetID;
  DoubleSheetPage ({required this.documnetID,});

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


  @override
  Widget build(BuildContext context) {

    CollectionReference buses = FirebaseFirestore.instance.collection('buses');

    return FutureBuilder(
      future: buses.doc(documnetID).get(),
        builder: ((context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done){
    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

    String email = '${data['email']}';

    List<String> pointlist = List.from(data['book_sheet']);

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

                    SizedBox(width: 100,),
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('03')){
                            return BookSheet(
                              onTop: () {},
                              text: '04',
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
                              text: '04',
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
                          if ( pointlist.contains('05')){
                            return BookSheet(
                              onTop: () {},
                              text: '05',
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
                                    builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet6))
                            );},
                            text: '06',
                          );
                        }),

                    SizedBox(width: 100,),
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('07')){
                            return BookSheet(
                              onTop: () {},
                              text: '04',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet7)),
                            );},
                            text: '07',
                          );
                        }),
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
                          if ( pointlist.contains('09')){
                            return BookSheet(
                              onTop: () {},
                              text: '05',
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
                              text: '06',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet10))
                            );},
                            text: '10',
                          );
                        }),

                    SizedBox(width: 100,),
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('11')){
                            return BookSheet(
                              onTop: () {},
                              text: '04',
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
                              text: '04',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet12)),
                            );},
                            text: '12',
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
                          if ( pointlist.contains('13')){
                            return BookSheet(
                              onTop: () {},
                              text: '05',
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
                              text: '06',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet14))
                            );},
                            text: '14',
                          );
                        }),

                    SizedBox(width: 100,),
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
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('16')){
                            return BookSheet(
                              onTop: () {},
                              text: '04',
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
                          if ( pointlist.contains('17')){
                            return BookSheet(
                              onTop: () {},
                              text: '05',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet17)),
                            );},
                            text: '17',
                          );
                        }),
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('18')){
                            return BookSheet(
                              onTop: () {},
                              text: '06',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet18))
                            );},
                            text: '18',
                          );
                        }),

                    SizedBox(width: 100,),
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
                              text: '05',
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
                              text: '06',
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

                    SizedBox(width: 100,),
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
                          if ( pointlist.contains('25')){
                            return BookSheet(
                              onTop: () {},
                              text: '05',
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
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('26')){
                            return BookSheet(
                              onTop: () {},
                              text: '06',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet26))
                            );},
                            text: '26',
                          );
                        }),

                    SizedBox(width: 100,),
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('27')){
                            return BookSheet(
                              onTop: () {},
                              text: '04',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet27)),
                            );},
                            text: '27',
                          );
                        }),
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
                          if ( pointlist.contains('29')){
                            return BookSheet(
                              onTop: () {},
                              text: '05',
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
                              text: '06',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet30))
                            );},
                            text: '30',
                          );
                        }),

                    SizedBox(width: 100,),
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('31')){
                            return BookSheet(
                              onTop: () {},
                              text: '04',
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
                              text: '04',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet32)),
                            );},
                            text: '32',
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
                          if ( pointlist.contains('33')){
                            return BookSheet(
                              onTop: () {},
                              text: '05',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet33)),
                            );},
                            text: '33',
                          );
                        }),
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('34')){
                            return BookSheet(
                              onTop: () {},
                              text: '06',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet34))
                            );},
                            text: '34',
                          );
                        }),

                    SizedBox(width: 100,),
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
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('36')){
                            return BookSheet(
                              onTop: () {},
                              text: '04',
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
                          if ( pointlist.contains('37')){
                            return BookSheet(
                              onTop: () {},
                              text: '05',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet37)),
                            );},
                            text: '37',
                          );
                        }),
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('38')){
                            return BookSheet(
                              onTop: () {},
                              text: '06',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet38))
                            );},
                            text: '38',
                          );
                        }),

                    SizedBox(width: 100,),
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
                    SizedBox(width: 100,),

                    SizedBox(width: 100,),
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('41')){
                            return BookSheet(
                              onTop: () {},
                              text: '04',
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
                              text: '04',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet42)),
                            );},
                            text: '42',
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
                          if ( pointlist.contains('43')){
                            return BookSheet(
                              onTop: () {},
                              text: '05',
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
                              text: '06',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookingPage(documnetID: documnetID,sheet1: sheet44))
                            );},
                            text: '44',
                          );
                        }),

                    SizedBox(width: 100,),
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
                                  builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet45)),
                            );},
                            text: '45',
                          );
                        }),
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('46')){
                            return BookSheet(
                              onTop: () {},
                              text: '04',
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
                          if ( pointlist.contains('47')){
                            return BookSheet(
                              onTop: () {},
                              text: '04',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet47)),
                            );},
                            text: '47',
                          );
                        }),
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
                            text: '49',
                          );
                        }),
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('51')){
                            return BookSheet(
                              onTop: () {},
                              text: '04',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet51)),
                            );},
                            text: '50',
                          );
                        }),
                    FutureBuilder(
                        future: buses.doc(documnetID).get(),
                        builder: (context, snapshot){
                          if ( pointlist.contains('52')){
                            return BookSheet(
                              onTop: () {},
                              text: '04',
                            );
                          }
                          return SheetButton(
                            onTop: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  BookingPage(documnetID: documnetID,sheet1: sheet52)),
                            );},
                            text: '51',
                          );
                        }),
                  ],
                ),
              ),
            ),

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
