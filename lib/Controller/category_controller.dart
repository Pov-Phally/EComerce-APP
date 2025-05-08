import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_online_store_admin/utils/Message%20Alart/alert_message.dart';
import '../Model/categorie_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController parentIdController = TextEditingController();
  final RxBool isFeatured = false.obs;

  final _db = FirebaseFirestore.instance;

  //Add category
  Future<void> addCategory(CategoriesModel category) async {
    try {
      await _db
          .collection('categories')
          .doc(category.id)
          .set(category.toJson());
      showAlert(Get.context!, 'Category Added Successfully');
      update();
      Get.back();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}