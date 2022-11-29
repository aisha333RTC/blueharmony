import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class serviceCategoryClass {
  final String? id;
  final String? categoryName;

  serviceCategoryClass({
    this.id,
    this.categoryName,
  });

  Map<String, dynamic> toMap() {
    return {
      "categoryName": categoryName,
    };
  }

  serviceCategoryClass.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        categoryName = doc.data()!["categoryName"];
}
