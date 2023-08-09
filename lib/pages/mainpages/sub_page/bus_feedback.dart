import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BusFeedBackPage extends StatefulWidget {
  String documnetID;

  BusFeedBackPage({required this.documnetID});

  @override
  State<BusFeedBackPage> createState() => _BusFeedBackPageState();
}

class _BusFeedBackPageState extends State<BusFeedBackPage> {
  final feedbackController = TextEditingController();

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  void addsheetbus() {
    add(feedbackController.text.trim());
  }

  Future<void> add(String feedback) async {
    await FirebaseFirestore.instance
        .collection('buses')
        .doc(widget.documnetID)
        .update({
      'feedback': FieldValue.arrayUnion([feedback]),
    });
  }

  CollectionReference buses = FirebaseFirestore.instance.collection('buses');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: buses.doc(widget.documnetID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF937047),
              title: Text('Bus Profile'),
            ),
            backgroundColor: Color(0xFFe7dac7),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 0.0),
                            child: Text(
                              'Give FeedBack',
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

                    Text('${data['bus_no']}',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),

                    Text('${data['bus_name']}',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),

                    SizedBox(height: 10,),

                    //Text give
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Container(
                        height: 200,
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(
                                  controller: feedbackController,
                                  decoration:
                                  InputDecoration(labelText: '   Enter Your FeedBack...'),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  expands: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),

                    GestureDetector(
                      onTap:  addsheetbus,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        decoration: BoxDecoration(
                          color: Color(0xFF937047),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "Submit",
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
        //Loading
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF937047),
            title: Text('Bus Profile'),
          ),
          backgroundColor: Color(0xFFe7dac7),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                          child: Text(
                            'Give FeedBack',
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
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
