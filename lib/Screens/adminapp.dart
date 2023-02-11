import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_management/Screens/delCollector.dart';
import 'package:food_management/Screens/showAvailableItems.dart';
import 'package:panorama/panorama.dart';
import '../Screens/delProvider.dart';
import 'Login.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(41, 255, 193, 7),
      appBar: AppBar(
        title: Text("Admin Portal"),
        actions: [
          Row(
            children: [
              const Text("Logout",style: TextStyle(fontWeight: FontWeight.bold),),
              IconButton(
                onPressed: () {
                  logout(context);
                },
                icon: const Icon(
                  Icons.logout,
                ),
              ),
            ],
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
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
                height: 140,
                child: Center(child: Text("delete Provider",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
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
                height: 140,
                child: Center(child: Text("delete collector",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
              ),
            ),
          ),
          InkWell(
            onTap: () {
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
                height: 140,
                child: Center(child: Text("Items Management",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }