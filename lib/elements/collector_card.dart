import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CollectorCard extends StatelessWidget {
  const CollectorCard({Key? key, required this.field, required this.value}) : super(key: key);

  final value;
  final String field;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children:  [
           Text('$field: ', style: TextStyle(
              color: kFieldNameColor,
              fontSize: 20
          ),),
          Text(value, style: const TextStyle(
              color: kShopNameColor,
              fontSize: 20
          ),),
        ],
      ),
    );
  }
}
