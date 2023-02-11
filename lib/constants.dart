import 'package:flutter/material.dart';

const kShopNameColor = Color(0xffF6E7D8);
const kFieldNameColor = Colors.black;
showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}