import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewFeedbackPage extends StatefulWidget {
  String documnetID;

  ViewFeedbackPage({required this.documnetID});

  @override
  State<ViewFeedbackPage> createState() => _ViewFeedbackPageState();
}

class _ViewFeedbackPageState extends State<ViewFeedbackPage> {

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: buses.doc(widget.documnetID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF937047),
              title: Text('Bus Profile'),
            ),
            backgroundColor: Color(0xFFe7dac7),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF937047),
              title: Text('Bus Profile'),
            ),
            backgroundColor: Color(0xFFe7dac7),
            body: Center(
              child: Text('Null'),
            ),
          );
        }
        if (snapshot.hasData) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          List<dynamic> feedbackArray = data['feedback'] ?? [];

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
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: feedbackArray.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  color: Colors.black,
                                  size: 35,
                                ),
                                SizedBox(width: 20,),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    color: Colors.black12,
                                  ),
                                  width: 320,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(feedbackArray[index],style:
                                        TextStyle(
                                            fontSize: 18
                                        ),),
                                      ],
                                    ),
                                  ),),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return SizedBox.shrink(child: Text('no'),);
      }),
    );
  }
}
