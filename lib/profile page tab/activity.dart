
import 'package:custom_switch_widget/custom_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';


class ActivityPage extends StatefulWidget {
  int a = 0;
  late String b;

   ActivityPage({Key? key}) : super(key: key);
  
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final nameController = TextEditingController();
  int a = 0;
  late String b;

  TimeOfDay _timeOfDay = TimeOfDay(hour: 08, minute: 30);
  TimeOfDay _timeOfDay1 = TimeOfDay(hour: 08, minute: 30);

  //show Time Picker
  void _showTimePicker(){
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  //show Time Picker
  void _showTimePicker1(){
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay1 = value!;
      });
    });
  }

  bool value = false;
  bool theme = false;
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    _controller.addListener(
        () {
          setState(() {
            if (_controller.value){
              theme = true;
            } else {
              theme = false;
            }
          });
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe7dac7),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: [
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
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                        child: Text(
                          'Activity',
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

                AdvancedSwitch(
                  controller: _controller,
                  enabled: true,
                  height: 35,
                  width: 120,
                  borderRadius: BorderRadius.all(
                    Radius.circular(120),
                  ),
                  inactiveColor: Colors.black26,
                  inactiveChild: Text("Offline"),
                  activeChild: Text("Online"),
                  thumb: ValueListenableBuilder<bool>(
                    valueListenable: _controller,
                    builder: (context, value, child){
                      return Icon(
                          _controller.value
                              ? Icons.online_prediction_rounded
                              : Icons.offline_bolt_outlined,
                        size: 30,
                        color: Colors.white,
                      );
                    },
                  ),
                ),

                SizedBox(height: 10,),

                Container(
                  height: 250,
                  width: 340,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    color: Colors.black12,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text('Set Time',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                        ),
                        Container(
                          child: Text('Kandy - Panadura',style: TextStyle(
                            fontSize: 17
                          ),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_timeOfDay.format(context).toString(),
                              style: TextStyle(
                              fontSize: 20,
                            ),
                            ),
                            SizedBox(width: 80,),
                            Text(_timeOfDay1.format(context).toString(),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        //show Time Set
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: _showTimePicker,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Start Time',
                              style: TextStyle(color: Colors.white, fontSize: 13),),
                            ),
                              color: Color(0xFF937047),
                            ),
                            SizedBox(width: 50,),
                            MaterialButton(
                              onPressed: _showTimePicker1,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Start Time',
                                  style: TextStyle(color: Colors.white, fontSize: 13),),
                              ),
                              color: Color(0xFF937047),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(horizontal:30,vertical: 5),
                            decoration: BoxDecoration(
                              color: Color(0xFF937047),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                "SUBMIT",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
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
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                        child: Text(
                          'Activity',
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
                Container(
                  height: 250,
                  width: 340,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    color: Colors.black12,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                      ],
                    ),
                  ),
                )
              ],
            ),
        ),
    ),
    );
  }
}
