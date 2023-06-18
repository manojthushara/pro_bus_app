import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/sub_page/search_bar_bus.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchValue = '';
  final List<String> _suggestions = ['Kandy - Paradura', 'Kandy - Colombo', 'Kandy - Anuradhapura', 'Kandy - Jaffna', 'Kandy - Kuruunagala', 'Kandy - Galle', 'Kandy - Hambanthota', 'Kandy - Nuwaraeliya', 'Kandy - Badulla', 'Kandy - Madakalapuwa'];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            appBar: EasySearchBar(
                title: const Text('Search Bus Times',style: TextStyle(
                  color: Colors.white,
                ),),
                backgroundColor: Color(0xFF937047),
                onSearch: (value) => setState(() => searchValue = value),
                suggestions: _suggestions,
              iconTheme: IconThemeData(color: Colors.white)
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      Container(
                        height: 200,
                        width: 410,
                        color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text('Value: $searchValue'),
                                  ],
                                ),
                              ),
                            )
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
