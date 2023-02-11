import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/adminapp.dart';

void main() {
  runApp(const showAvailableItems());
}

class showAvailableItems extends StatefulWidget {
  const showAvailableItems({Key? key}) : super(key: key);

  @override
  State<showAvailableItems> createState() => _showAvailableItemsState();
}

class _showAvailableItemsState extends State<showAvailableItems> {
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
    );
  }
}
