import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSearchPage extends StatefulWidget {
  @override
  _FirebaseSearchPageState createState() => _FirebaseSearchPageState();
}

class _FirebaseSearchPageState extends State<FirebaseSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  void _searchFirestore(String searchQuery) {
    FirebaseFirestore.instance
        .collection('buses') // Replace with your collection name
        .where('email', isGreaterThanOrEqualTo: searchQuery)
        .where('bus_root', isLessThanOrEqualTo: searchQuery + '\uf8ff')
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        _searchResults = snapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Data Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchFirestore(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResults[index]['title']),
                  subtitle: Text(_searchResults[index]['subtitle']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
