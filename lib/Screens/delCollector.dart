import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../FirebaseMethod/firestoreMethod.dart';

class DelCollector extends StatefulWidget {
  const DelCollector({Key? key}) : super(key: key);

  @override
  State<DelCollector> createState() => _DelCollectorState();
}

class _DelCollectorState extends State<DelCollector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text("Delete Collector"),
        backgroundColor: Colors.transparent,
      ),
        body: Container(
            color: const Color.fromARGB(41, 255, 193, 7),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('rool', isEqualTo: 'Collector')
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
                                  }, icon: const Icon(Icons.delete))
                            ],
                          ),
                        );
                      });
                }
              },
            )));
  }
}
