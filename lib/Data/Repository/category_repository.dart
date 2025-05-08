import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../Model/categorie_model.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  //Fetch category
  Future<List<CategoriesModel>> fetchCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _db.collection('categories').get();
      return snapshot.docs
          .map((document) => CategoriesModel.fromSnapshot(document))
          .toList();
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}