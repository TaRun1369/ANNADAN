import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_management/Screens/Login.dart';

class Provider extends StatefulWidget {
  late String email;
  late String mobile;
  late String username;
  late String address;
  late String shopname;
  Provider(
      {super.key,
      required this.email,
      required this.address,
      required this.mobile,
      required this.shopname,
      required this.username});

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
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      child: const Text('Create'),
                      onPressed: () async {
                        final String name = widget.shopname;
                        final String username = widget.username;
                        final String Mobile = widget.mobile;
                        final String fooditem = _fooditemController.text;
                        final String location = widget.address;
                        final String foodAge = _foodAgeController.text;
                        final String email = widget.email;
                        final String foodQuantity =
                            _foodQuantityController.text;
                        await _items.add({
                          "ShopName": name,
                          "UserName": username,
                          "mobile" : Mobile ,
                          "Food items": fooditem,
                          "Location": location,
                          "foodAge": foodAge,
                          "emailId": email,
                          "foodQuantity": foodQuantity,
                          'Requests': []
                        });
                        _fooditemController.text = '';
                        _foodAgeController.text = '';
                        _foodQuantityController.text = '';
                        _emailController.text = '';
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['Name'];
      _foodAgeController.text = documentSnapshot['foodAge'].toString();
      _emailController.text = documentSnapshot['emailId'];
      _foodQuantityController.text =
          documentSnapshot['foodQuantity'].toString();
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
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      final String name = widget.shopname;
                       final String username = widget.username;
                        final String Mobile = widget.mobile;
                      final String fooditem = _fooditemController.text;
                      final String location = widget.address;
                      final String foogAge = _foodAgeController.text;
                      final String email = widget.email;
                      final String foodQuantity = _foodQuantityController.text;
                      await _items.doc(documentSnapshot!.id).update({
                        "Name": name,
                        "UserName": username,
                          "mobile" : Mobile ,
                        "Food items": fooditem,
                        "Location": location,
                        "foodAge": foogAge,
                        "emailId": email,
                        "foodQuantity": foodQuantity
                      });
                      _fooditemController.text = '';
                      _foodAgeController.text = '';
                      _foodQuantityController.text = '';
                      _emailController.text = '';
                      Navigator.of(context).pop();
                    },
                    child: const Text('Update data'),
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
        // title: Text("Shop name - ${widget.shopname}\nLocation - ${widget.address}"),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shop name - ${widget.shopname}",
              style: const TextStyle(fontSize: 22.0),
            ),
            Text(
              "Location - ${widget.address}",
              style: const TextStyle(fontSize: 15.0),
            )
          ],
        ),

        actions: [
          Row(
            children: [
              Text("Logout"),
              IconButton(
                onPressed: () {
                  logout(context);
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.blueGrey,
                ),
              ),
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
              Container(color: Colors.black87),
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
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.brown]),
                      ),
                      child: ListTile(
                        title: Text(
                            "Food item - ${documentSnapshot['Food items'].toString()}"),
                        subtitle: Text("""
Food Quantity - ${documentSnapshot['foodQuantity'].toString()},
Food Items - ${documentSnapshot['Food items'].toString()}"""),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.limeAccent,
                                  ),
                                  onPressed: () => _update(documentSnapshot)),
                              IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      _delete(documentSnapshot.id)),
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
        child: const Icon(Icons.add, color: Colors.yellowAccent),
      ),
    );
  }

  Future createItem({required String name}) async {
    final docItem = FirebaseFirestore.instance.collection('Items').doc('my-id');
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
