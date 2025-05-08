import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/All%20Products/all_products_controller.dart';
import '../../Reusable Widget/cs_gridview.dart';
import '../../Reusable Widget/items_card.dart';

class ProductByCategoryScreen extends StatelessWidget {
  const ProductByCategoryScreen({
    super.key,
    required this.title,
    required this.category,
  });
  final String title;
  final String category;

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(AllProductsController());
    productController.fetchProductsByCategory(category);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (productController.products.isEmpty) {
          return const Center(child: Text('No products found'));
        }
        return CSGridView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemCount: productController.products.length,
          itemBuilder: (_, index) {
            return CSItemsCard(product: productController.products[index]);
          },
        );
      }),
    );
  }
}