import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodData{
  final String foodItem;
  final String location;
  final String shopName;
  final double price;
  final String emailId;
  final int foodAge;
  final int foodQuantity;
  final String productId;

  FoodData({
    required this.foodItem,
    required this.location,
    required this.shopName,
    required this.price,
    required this.emailId,
    required this.foodAge,
    required this.foodQuantity,
    required this.productId,
});

  Map <String, dynamic> toJson() =>{
    "foodItem" : foodItem,
    "location" : location,
    "shopName" : shopName,
    "price" : price,
    "emailId" : emailId,
    "foodAge" : foodAge,
    "foodQuantity" : foodQuantity,
    "productId" : productId,
  };

  static FoodData fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return FoodData(
      foodItem: snapshot['foodItem'],
      location: snapshot['location'],
      shopName: snapshot['shopName'],
      price: snapshot['price'],
      emailId: snapshot['emailId'],
      foodAge: snapshot['foodAge'],
      foodQuantity: snapshot['foodQuantity'],
      productId: snapshot['productId'],
    );
  }








}