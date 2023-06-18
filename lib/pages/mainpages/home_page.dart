import 'package:flutter/material.dart';
import 'package:pro_bus_app/profile%20page%20tab/profiles_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe7dac7),
      appBar: AppBar(
        backgroundColor: Color(0xFF937047),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    child: Text('Home Page'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
