import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_management/Screens/Login.dart';

class Collector extends StatefulWidget {
  const Collector({super.key});

  @override
  State<Collector> createState() => _CollectorState();
}

class _CollectorState extends State<Collector> {
  final CollectionReference _items =
      FirebaseFirestore.instance.collection('Items');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Collector"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: _items.snapshots(), //build connection
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,  //number of rows
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['name of provider']),
                    subtitle: Text(documentSnapshot['Food items'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
// Press this button to edit a single product
//                           IconButton(
//                               icon: const Icon(Icons.edit),
//                               onPressed: () =>
//                                   _update(documentSnapshot)),
// // This icon button is used to delete a single product
//                           IconButton(
//                               icon: const Icon(Icons.delete),
//                               onPressed: () =>
//                                   _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
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