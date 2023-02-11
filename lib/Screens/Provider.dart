import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_management/Screens/Login.dart';

class Provider extends StatefulWidget {
  const Provider({super.key});

  @override
  State<Provider> createState() => _ProviderState();
}

class _ProviderState extends State<Provider> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.amber,
        title: const Text("Provider"),
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
      body: Column(
        children: [
          TextField(controller: controller),
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: (() {
                final name = controller.text;
                createItem(name: name);
              }))
        ],
      ),
    );
  }

  Future createItem({required String name}) async {
    final docItem = FirebaseFirestore.instance.collection('Items').doc('my-id');
    // var data = json.encode({
    //   'name of Proveider' = name
    // })
    // await docItem.set(json1);
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
