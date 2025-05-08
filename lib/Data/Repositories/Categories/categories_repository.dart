import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Model/categorie_model.dart';

class CategoriesRepository extends GetxController {
  static CategoriesRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Fetch All Categories
  Future<List<CategoriesModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('categories').get();
      final list =
          snapshot.docs
              .map((document) => CategoriesModel.fromSnapshot(document))
              .toList();
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception('Error fetching categories: $e');
    }
  }
}