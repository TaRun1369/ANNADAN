import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_management/Screens/Login.dart';

class Admin1 extends StatefulWidget {
  late String email;
  Admin1({super.key,required this.email});

  @override
  State<Admin1> createState() => _Admin1State();
}

class _Admin1State extends State<Admin1> {

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('Items');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(41, 255, 193, 7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        title: const Text("Admin",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        actions: [
          Row(
            children: [
              Text("Logout",),
              IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
            ],
          )
        ],
      ),
      body: StreamBuilder(
        stream: _items.snapshots(), //build connection
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length, //number of rows
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  color: Colors.amber,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(

                      title: Text(documentSnapshot['Name'],style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                       subtitle: Text(
                          """
Food Item - ${documentSnapshot['Food items'].toString()} 
Food Quantity - ${documentSnapshot['foodQuantity'].toString()}
Location - ${documentSnapshot['Location'].toString()}
Food Items - ${documentSnapshot['Food items'].toString()}"""
              ),                      
              ),
                    );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
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
}
