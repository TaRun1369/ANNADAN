
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_management/Screens/Login.dart';

class Provider extends StatefulWidget {
  late String email;
  Provider({super.key, required this.email});

  @override
  State<Provider> createState() => _ProviderState();
}

class _ProviderState extends State<Provider> {
  final TextEditingController _nameController = TextEditingController();
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
                // TextField(
                //   controller: _emailController,
                //   decoration: const InputDecoration(labelText: 'Price of Food'),

                // ),
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
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String fooditem = _fooditemController.text;
                    final String location = _LocationController.text;
                    final String foogAge = _foodAgeController.text;
                    final String email = widget.email;
                    final String foodQuantity = _foodQuantityController.text;
                    await _items.add({
                      "Name": name,
                      "Food items": fooditem,
                      "Location": location,
                      "foodAge": foogAge,
                      "emailId": email,
                      "foodQuantity": foodQuantity,
                      "Requests":[]
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
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['Name'];
      _foodAgeController.text = documentSnapshot['foodAge'];
      _emailController.text = documentSnapshot['emailId'];
      _foodQuantityController.text = documentSnapshot['foodQuantity'];
      _LocationController.text = documentSnapshot['Location'];
      _fooditemController.text = documentSnapshot['Food items'].toString();
    }

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
                // TextField(
                //   controller: _emailController,
                //   decoration: const InputDecoration(labelText: 'Price of Food'),

                // ),
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
                    final String fooditem = _fooditemController.text;
                    final String location = _LocationController.text;
                    final String foogAge = _foodAgeController.text;
                    final String email = widget.email;
                    final String foodQuantity = _foodQuantityController.text;
                    await _items.doc(documentSnapshot!.id).update({
                      "Name": name,
                      "Food items": fooditem,
                      "Location": location,
                      "foodAge": foogAge,
                      "emailId": email,
                      "foodQuantity": foodQuantity,
                      "Requests" :[],
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
        backgroundColor: Colors.transparent,

        title: const Text("Provider",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
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
        stream: _items.where("emailId", isEqualTo: widget.email).snapshots(),
        // stream: _items.snapshots(), //build connection
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Stack(children: [
              // dalo ihar kuch
              ListView.builder(
                itemCount: streamSnapshot.data!.docs.length, //number of rows
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['Name']),
                      subtitle: Text(
                          """
Food Item - ${documentSnapshot['Food items'].toString()} 
Food Quantity - ${documentSnapshot['foodQuantity'].toString()}
Location - ${documentSnapshot['Location'].toString()}
Food Items - ${documentSnapshot['Food items'].toString()}"""
              ),             
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _delete(documentSnapshot.id)),
                          ],
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
        onPressed: () {
          _create();
        },
        child: const Icon(Icons.add),
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
