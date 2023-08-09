
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pro_bus_app/pages/mainpages/home_page.dart';
import 'package:pro_bus_app/pages/mainpages/map_page.dart';
import 'package:pro_bus_app/pages/mainpages/profile_page.dart';
import 'package:pro_bus_app/pages/mainpages/search_page.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}
class _NavigationPageState extends State<NavigationPage> {
  int _selectedindex = 0;
  final List<Widget> _list = const [
    HomePage(),
    SearchPage(),
    MapPage(),
    ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list[_selectedindex],
      bottomNavigationBar:
      Container(
        color: Color(0xFF241f1c),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),

          child: GNav(
            backgroundColor: Color(0xFF241f1c),
            color: Color(0xFFe7dac7),
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            onTabChange: (newindex) => setState(() => _selectedindex = newindex),
            padding: EdgeInsets.all(16),
            tabs: const [

              GButton(
                icon: Icons.home,
                text: 'Home',
              ),

              GButton(
                icon: Icons.search,
                text: 'Search',
              ),

              GButton(
                icon: Icons.map,
                text: 'Map',
              ),

              GButton(
                icon: Icons.account_circle,
                text: 'Profile',
              ),

            ],
          ),
        ),
      ),
    );
  }
}
