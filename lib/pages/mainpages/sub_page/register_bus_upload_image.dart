import 'package:flutter/material.dart';

class BusUpoadImage extends StatefulWidget {


  @override
  State<BusUpoadImage> createState() => _BusUpoadImageState();
}

class _BusUpoadImageState extends State<BusUpoadImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF937047),
        title: Text('Register'),
      ),
      backgroundColor: Color(0xFFe7dac7),
      body: Center(
        child: Container(
          height: 750,
          width: 370,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
            color: Colors.black12,
          ),
          child: Column()
        ),
      ),
    );
  }
}
