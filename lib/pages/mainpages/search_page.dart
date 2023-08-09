import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/booking_pages/bus_sheet.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/live_bus_location.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/search_buses.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/view_bus_profile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> docIDS = []; // Add this line
  List<String> filteredDocIDS = [];

  @override
  void initState() {
    super.initState();
    getUserProfilePicture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe7dac7),
      appBar: AppBar(
        title: CupertinoSearchTextField(
          controller: _searchController,
          onSubmitted: (_) {
            searchResultList();
          },
        ),
        backgroundColor: Color(0xFF937047),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: filteredDocIDS.isEmpty
          ? Center(child: Text('No buses found.'))
          : ListView.builder(
        itemCount: filteredDocIDS.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 35, vertical: 10),
            child: GetSearchBusesList(
                documentId: filteredDocIDS[index]),
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getBusDataFromFirestore(String docID) async {
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection('buses').doc(docID).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  void getUserProfilePicture() async {
    final snapshot = await FirebaseFirestore.instance.collection('buses').get();
    setState(() {
      docIDS = snapshot.docs.map((document) => document.id).toList();
      filteredDocIDS = docIDS; // Initially, show all buses
    });
  }

  void searchResultList() async {
    final searchQuery = _searchController.text.toLowerCase();
    final filteredList = <String>[];

    for (final docID in docIDS) {
      final busData = await getBusDataFromFirestore(docID);
      final fieldToSearch = busData['bus_root']
          .toString()
          .toLowerCase(); // Replace with the actual field name to search

      print('Searching for: $searchQuery, Field Value: $fieldToSearch');

      if (fieldToSearch.contains(searchQuery)) {
        filteredList.add(docID);
      }
    }

    setState(() {
      filteredDocIDS = filteredList;
    });
  }

}



