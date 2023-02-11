import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/adminapp.dart';


void main() {
  runApp(const DelCollector());
}

class DelCollector extends StatefulWidget {
  const DelCollector({Key? key}) : super(key: key);

  @override
  State<DelCollector> createState() => _DelCollectorState();
}

class _DelCollectorState extends State<DelCollector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Colors.black,
            child: Text("Email"),
          ),
        ],
      ),
    );;
  }
}
