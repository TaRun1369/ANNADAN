import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/adminapp.dart';


void main() {
  runApp(const DelProvider());
}

class DelProvider extends StatefulWidget {
  const DelProvider({Key? key}) : super(key: key);

  @override
  State<DelProvider> createState() => _DelProviderState();
}

class _DelProviderState extends State<DelProvider> {
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
