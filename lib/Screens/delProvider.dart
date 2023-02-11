import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';



import 'package:food_management/FirebaseMethod/adminFirestoreMethods.dart';
import '../FirebaseMethod/firestoreMethod.dart';
import '../Screens/adminapp.dart';

class DelProvider extends StatefulWidget {
  const DelProvider({Key? key}) : super(key: key);

  @override
  State<DelProvider> createState() => _DelProviderState();
}

class _DelProviderState extends State<DelProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text("Delete Providers"),
        backgroundColor: Colors.transparent,
      ),
        body: Container(
            color: Color.fromARGB(41, 255, 193, 7),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('rool', isEqualTo: 'Provider')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                        (snapshot.data! as dynamic).docs[index];
                        return Card(
                          color: Colors.amber,
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(snap['email']),
                              IconButton(
                                  onPressed: () async {
                                    await FireStoreMethods().removeProvider(snap.id);
                                  }, icon: Icon(Icons.delete))
                            ],
                          ),
                        );
                      });
                }
              },
            )));
  }
}
