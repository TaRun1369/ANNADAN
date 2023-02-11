import 'package:flutter/material.dart';
import 'package:food_management/Screens/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_management/Screens/adminapp.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("messed it bro sed");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginPage();
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}


