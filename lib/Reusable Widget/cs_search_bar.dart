import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/All Products/all_products_controller.dart';
import '../View/Search Product/search_product_screen.dart';

class CSSearchBar extends StatelessWidget {
  const CSSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(AllProductsController());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 10),
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'What are you looking for?',
                hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                border: InputBorder.none,
              ),
              controller: productController.searchController,
              onSubmitted: (value) {
                Get.to(() => SearchProductScreen());
                productController.searchProducts(value);
                productController.clearSearch();
              },
            ),
          ),
        ],
      ),
    );
  }
}