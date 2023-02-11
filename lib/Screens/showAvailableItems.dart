// // import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../FirebaseMethod/firestoreMethod.dart';

// class showAvailableItems extends StatefulWidget {
//   const showAvailableItems({Key? key}) : super(key: key);

//   @override
//   State<showAvailableItems> createState() => _showAvailableItemsState();
// }

// class _showAvailableItemsState extends State<showAvailableItems> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: const Color.fromARGB(41, 255, 193, 7),
//         child: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('Items').snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               return ListView.builder(
//                   itemCount: (snapshot.data! as dynamic).docs.length,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot snap =
//                         (snapshot.data! as dynamic).docs[index];
//                     return Card(
//                       color: Colors.amber,
//                       margin: const EdgeInsets.all(10),
//                       child: ListTile(
//                         title: Text(snap['Name']),
//                         subtitle: Text(
//                           "${snap['Food items']}, ${snap['foodQuantity']}",
//                         ),
//                       ),
//                     );
//                   });
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_management/Screens/Login.dart';

class showAvailableItems extends StatefulWidget {
  showAvailableItems({super.key,});

  @override
  State<showAvailableItems> createState() => _showAvailableItemsState();
}

class _showAvailableItemsState extends State<showAvailableItems> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _shopController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _fooditemController = TextEditingController();
  final TextEditingController _LocationController = TextEditingController();
  final TextEditingController _foodAgeController = TextEditingController();
  final TextEditingController _foodQuantityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('Items');
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('Users');
  final controller = TextEditingController();

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: Colors.amberAccent,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration:
                        const InputDecoration(labelText: 'Name of Item'),
                  ),
                  TextField(
                    controller: _shopController,
                    decoration:
                        const InputDecoration(labelText: 'Name of Shop'),
                  ),
                  TextField(
                    controller: _mobileController,
                    decoration:
                        const InputDecoration(labelText: 'Mobile number'),
                  ),
                  TextField(
                    controller: _LocationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _foodAgeController,
                    decoration: const InputDecoration(labelText: 'Age of Food'),
                  ),
                  TextField(
                    controller: _fooditemController,
                    decoration: const InputDecoration(
                      labelText: 'fooditem',
                    ),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email ID'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _foodQuantityController,
                    decoration: const InputDecoration(
                      labelText: 'Kilo Grams of Food',
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Create'),
                    style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      final String name = _nameController.text;
                      final String shop = _shopController.text;
                      final String mobile = _mobileController.text;
                      final String fooditem = _fooditemController.text;
                      final String location = _LocationController.text;
                      final String foodAge = _foodAgeController.text;
                      final String email = _emailController.text;
                      final String foodQuantity = _foodQuantityController.text;
                      await _items.add({
                        "ShopName": shop,
                          "UserName":name,
                          "mobile" : mobile,
                          "Food items": fooditem,
                          "Location": location,
                          "foodAge": foodAge,
                          "emailId": email,
                          "foodQuantity": foodQuantity,
                          'Requests': []
                      });
                      _nameController.text = '';
                      _fooditemController.text = '';
                      _foodAgeController.text = '';
                      _foodQuantityController.text = '';
                      _LocationController.text = '';
                      _emailController.text = '';
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['UserName'];
      _foodAgeController.text = documentSnapshot['foodAge'].toString();
      _emailController.text = documentSnapshot['emailId'];
      _foodQuantityController.text = documentSnapshot['foodQuantity'].toString();
      _LocationController.text = documentSnapshot['Location'];
      _fooditemController.text = documentSnapshot['Food items'];
    }

    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: Colors.amberAccent,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration:
                        const InputDecoration(labelText: 'Name of Provider'),
                  ),
                  TextField(
                    controller: _LocationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _foodAgeController,
                    decoration: const InputDecoration(labelText: 'Age of Food'),
                  ),
                  TextField(
                    controller: _fooditemController,
                    decoration: const InputDecoration(
                      labelText: 'fooditem',
                    ),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email ID'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: _foodQuantityController,
                    decoration: const InputDecoration(
                      labelText: 'Kilo Grams of Food',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Update'),
                    onPressed: () async {
                      final String name = _nameController.text;
                      final String shop = _shopController.text;
                        final String mobile = _mobileController.text;
                      final String fooditem = _fooditemController.text;
                      final String location = _LocationController.text;
                      final String foodAge = _foodAgeController.text.toString();
                      final String email = _LocationController.text;
                      final String foodQuantity = _foodQuantityController.text.toString();
                      await _items.doc(documentSnapshot!.id).update({
                        "ShopName": shop,
                            "UserName":name,
                            "mobile" : mobile,
                            "Food items": fooditem,
                            "Location": location,
                            "foodAge": foodAge,
                            "emailId": email,
                            "foodQuantity": foodQuantity,
                            'Requests': []
                      });
                      _nameController.text = '';
                      _fooditemController.text = '';
                      _foodAgeController.text = '';
                      _foodQuantityController.text = '';
                      _LocationController.text = '';
                      _emailController.text = '';
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _items.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.9),
        foregroundColor: Colors.amber,
        title: const Text("Edit items"),
      ),
      body: StreamBuilder(
        stream: _items.snapshots(),
        // stream: _items.snapshots(), //build connection
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Stack(

                children: [
                  Container(color:Colors.black87),
              // dalo ihar kuch
              ListView.builder(
                itemCount: streamSnapshot.data!.docs.length, //number of rows
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    color: Colors.transparent,
                    margin: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(colors: [Colors.orange,Colors.brown]),
                      ),
                      child: ListTile(
                        title: Text(documentSnapshot['UserName']),
                        subtitle: Text(
                            """
Food Item - ${documentSnapshot['Food items'].toString()},
Food Quantity - ${documentSnapshot['foodQuantity'].toString()},
Location - ${documentSnapshot['Location'].toString()}
Food Items - ${documentSnapshot['Food items'].toString()}"""),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.edit,color: Colors.limeAccent,),
                                  onPressed: () => _update(documentSnapshot)),
                              IconButton(
                                  icon: const Icon(Icons.delete,color: Colors.red,),
                                  onPressed: () => _delete(documentSnapshot.id)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ]);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          _create();
        },
        child: const Icon(Icons.add,color: Colors.yellowAccent),
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
