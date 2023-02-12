import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_upi_payment/easy_upi_payment.dart';
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
      backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            decoration: BoxDecoration(borderRadius:const  BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),color: Colors.amber[300],),

            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("""
Name - ${documentSnapshot!['UserName']},
Shop Name - ${documentSnapshot['ShopName']},
Food items - ${documentSnapshot['Food items']},
Location - ${documentSnapshot['Location']},
FoodAge - ${documentSnapshot['foodAge'].toString()},
FoodQuantity - ${documentSnapshot['foodQuantity'].toString()}
                  """,
                  style: TextStyle(fontSize: 20),),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ElevatedButton(

                          child: const Text('Request Order'),
                          onPressed: () async {
                            await FirebaseFirestore.instance.collection('Items').doc(documentSnapshot.id).update({
                              'Requests': FieldValue.arrayUnion([widget.email])
                            });},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                  textStyle: TextStyle(

                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)
          ),
          ),
          ElevatedButton(
                      
                          child: const Text('Donate'),
                          onPressed: () async {
                            await EasyUpiPaymentPlatform.instance.startPayment(
                                const EasyUpiPaymentModel(
                                    payeeVpa: 'sunay.bhoyar@oksbi',
                                    payeeName: 'Sunay Bhoyar',
                                    amount: 10.0,
                                    description: 'Testing payment',
                                  ),
                                );
                            },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                  textStyle: TextStyle(

                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)
          ),
          ),
                    ],
                  )

                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(41, 255, 193, 7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Collector",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        actions: [
          Row(
            children: [
              const Text("Logout",style: TextStyle(fontWeight: FontWeight.bold),),
              IconButton(
                onPressed: () {
                  logout(context);
                },
                icon: const Icon(
                  Icons.logout,
                ),
              ),
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
                return InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: () => _bookdata(documentSnapshot),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      height: 240,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xffF5EAEE), gradient: LinearGradient(
                        colors: [Color(0xffF68989),Color(0xffC65D7B), Color(0xff874356)],
                      ),),
                      child: Column(
                        children: [
                          CollectorCard(field: 'UserName', value: documentSnapshot['UserName']),
                          CollectorCard(field: 'Shop Name', value: documentSnapshot['ShopName']),
                          CollectorCard(field: 'Address', value: documentSnapshot['Location']),
                          CollectorCard(field: 'Food Items', value: documentSnapshot['Food items']),
                          CollectorCard(field: 'Food Quantity', value: documentSnapshot['foodQuantity']),
                          CollectorCard(field: 'Food Age', value: documentSnapshot['foodAge'].toString()),
                        ],

                      ),
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
