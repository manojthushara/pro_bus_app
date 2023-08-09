import 'package:flutter/material.dart';
import 'package:pro_bus_app/profile%20page%20tab/activity.dart';
import 'package:pro_bus_app/profile%20page%20tab/user_profile.dart';
import 'package:pro_bus_app/profile%20page%20tab/bus_profile_page.dart';

import '../pages/map_assistant/testting.dart';


class ProfilesBar extends StatelessWidget {
  ProfilesBar ({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF937047),
            title: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.account_box)),
                Tab(icon: Icon(Icons.bus_alert_rounded)),
                Tab(icon: Icon(Icons.local_activity_rounded)),
              ],
            ),
          ),
          body:  TabBarView(
            children: <Widget>[
              UserProfilePage(),
              BusProfilePage(),
              ActivityPage()
            ],
          )),
    );
  }
}