import 'package:flutter/material.dart';
import 'package:food_management/Screens/delCollector.dart';
import 'package:food_management/Screens/showAvailableItems.dart';
import 'package:panorama/panorama.dart';
import '../Screens/delProvider.dart';


void main() {
  runApp(const Admin());
}

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    final SensorControl sensorControl = SensorControl.AbsoluteOrientation;
    return MaterialApp(
      home: Stack(
          children:[
            Panorama(
              animSpeed: 0.5,
              sensorControl: SensorControl.Orientation,
              child: Image.asset('images/123.jpeg', fit: BoxFit.cover),
            ),
            Scaffold(

              appBar: AppBar(title: Text("Admin Portal"),
                backgroundColor: Colors.cyan,),
              body: ListView(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DelProvider()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.greenAccent,
                        ),
                        height: 100,
                        child: Center(child: Text("delete collector")),

                      ),
                    ),
                  ),
                  InkWell(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DelCollector()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amberAccent,
                        ),
                        height: 100,
                        child: Center(child: Text("delete provider")),

                      ),
                    ),
                  ),
                  InkWell(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => showAvailableItems()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.redAccent,
                        ),
                        height: 100,
                        child: Center(child: Text("show items available")),


                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.indigo,
                        ),
                        height: 100,
                        child: Center(child: Text("items edit")),

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }
}
