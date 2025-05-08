import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../Model/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Fetch feature products with limit
  Future<List<ProductModel>> getFeatureProduct() async {
    try {
      final snapshot =
          await _db
              .collection('Products')
              .where('isFeatured', isEqualTo: true)
              .limit(4)
              .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Error fetching feature products: $e');
    }
  }

  //Fetch all feature products
  Future<List<ProductModel>> getAllFeatureProduct() async {
    try {
      final snapshot =
          await _db
              .collection('Products')
              .where('isFeatured', isEqualTo: true)
              .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Error fetching feature products: $e');
    }
  }

  //Fetch products by query
  Future<List<ProductModel>> fetchProductByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList =
          querySnapshot.docs
              .map((doc) => ProductModel.fromQuerySnapshot(doc))
              .toList();
      return productList;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
      throw Exception('Error fetching products:');
    }
  }

  //Fetch products by category
  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    try {
      final snapshot =
          await _db
              .collection('Products')
              .where('category', isEqualTo: category)
              .get();
      final products =
          snapshot.docs
              .map((document) => ProductModel.fromQuerySnapshot(document))
              .toList();
      return products;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products by category: $e');
      }
      throw Exception('Error fetching products by category: $e');
    }
  }
}