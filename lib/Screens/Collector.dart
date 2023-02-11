import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_management/Screens/Login.dart';
import 'package:food_management/constants.dart';
import 'package:food_management/elements/collector_card.dart';

class Collector extends StatefulWidget {
  late String email;
  Collector({super.key,required this.email});

  @override
  State<Collector> createState() => _CollectorState();
}

class _CollectorState extends State<Collector> {

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('Items');

  Future<void> _bookdata([DocumentSnapshot? documentSnapshot]) async {

    
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(documentSnapshot!['Name']),
                Text(documentSnapshot['Food items']),
                Text(documentSnapshot['Location']),
                Text(documentSnapshot['foodAge'].toString()),
                Text(documentSnapshot['foodQuantity'].toString()),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    await FirebaseFirestore.instance.collection('Items').doc(documentSnapshot.id).update({
                          'Requests': FieldValue.arrayUnion([widget.email])
                    });
                  }
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(41, 255, 193, 7),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 191, 0),
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
              itemCount: streamSnapshot.data!.docs.length, //number of rows
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 400,
                    height: 150,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffF5EAEE), gradient: LinearGradient(
                      colors: [Color(0xffF68989),Color(0xffC65D7B), Color(0xff874356)],
                    ),),
                    child: Column(
                      children: [
                        CollectorCard(field: 'Shop Name', value: documentSnapshot['Name']),
                        CollectorCard(field: 'Food Items', value: documentSnapshot['Food items']),
                        CollectorCard(field: 'Food Quantity', value: documentSnapshot['foodQuantity']),
                      ],
                    ),
                  ),
                );
                // return Card(
                //   color: Colors.amber,
                //     margin: const EdgeInsets.all(10),
                //     child: ListTile(
                //       onTap: () => _bookdata(documentSnapshot),
                //       title: Text(documentSnapshot['Name']),
                //       subtitle: Text(
                //           "${documentSnapshot['Food items'].toString()}, ${documentSnapshot['foodQuantity'].toString()}"),
                //       ),
                //     );
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
