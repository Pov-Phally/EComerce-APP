import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/All Products/all_products_controller.dart';
import '../../Model/product_model.dart';
import '../../Reusable Widget/cs_sortable_product.dart';

class AllFeatureProductsScreen extends StatelessWidget {
  const AllFeatureProductsScreen({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });
  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;
  @override
  Widget build(BuildContext context) {
    final productController = Get.put(AllProductsController());
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder(
        future: futureMethod ?? productController.fetchProductByQuery(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Text('No data found');
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return CSSortableProduct(products: snapshot.data!);
        },
      ),
    );
  }
}