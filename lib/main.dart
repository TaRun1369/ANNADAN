import 'package:flutter/material.dart';
import 'package:food_management/Screens/Login.dart';
import 'package:firebase_core/firebase_core.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Text("fucked up");
          }
    
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginPage();
          }
    
          // Otherwise, show something whilst waiting for initialization to complete
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}


