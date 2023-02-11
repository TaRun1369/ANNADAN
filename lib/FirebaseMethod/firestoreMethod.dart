import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_management/Model/foodData.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> removeEntry(String productId) async {
    try {
      _firebaseFirestore.collection('Items').doc(productId).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> removeProvider(String uid) async {
    try{
      _firebaseFirestore.collection('users').doc(uid).delete();
    }catch(err){
      print(err.toString());
    }
  }

  Future<void> removeCollector(String uid) async {
    try{
      _firebaseFirestore.collection('users').doc(uid).delete();
    }catch(err){
      print(err.toString());
    }
  }

  Future<void> addEntry(String foodItem, String location, String shopName,
      double price, String emailId, int foodAge, int foodQuantity) async {
    try {
      String productId = const Uuid().v1();
      FoodData foodData = FoodData(
          foodItem: foodItem,
          location: location,
          shopName: shopName,
          price: price,
          emailId: emailId,
          foodAge: foodAge,
          foodQuantity: foodQuantity,
          productId: productId);
      _firebaseFirestore
          .collection('Items')
          .doc(productId)
          .set(foodData.toJson());
    } catch (err) {
      print(err.toString());
    }
  }
}
