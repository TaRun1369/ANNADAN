// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../FirebaseMethod/firestoreMethod.dart';

class showAvailableItems extends StatefulWidget {
  const showAvailableItems({Key? key}) : super(key: key);

  @override
  State<showAvailableItems> createState() => _showAvailableItemsState();
}

class _showAvailableItemsState extends State<showAvailableItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(41, 255, 193, 7),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Items').snapshots(),
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
                      child: ListTile(
                        title: Text(snap['Name']),
                        subtitle: Text(
                          "${snap['Food items']}, ${snap['foodQuantity']}",
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
