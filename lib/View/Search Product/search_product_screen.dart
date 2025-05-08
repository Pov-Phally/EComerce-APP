import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_online_store/Reusable%20Widget/cs_gridview.dart';
import 'package:kh_online_store/Reusable%20Widget/cs_search_bar.dart';
import '../../Controller/All Products/all_products_controller.dart';
import '../../Reusable Widget/items_card.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final productController = Get.put(AllProductsController());

  void searchProducts(String query) {
    if (query.isNotEmpty) {
      productController.searchProducts(query);
    } else {
      productController.searchedProducts.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Products')),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0), child: CSSearchBar()),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (productController.searchedProducts.isEmpty) {
                return Center(child: Text('No Products Found'));
              }
              return CSGridView(
                padding: EdgeInsets.all(10),
                itemCount: productController.searchedProducts.length,
                itemBuilder: (_, index) {
                  final product = productController.searchedProducts[index];
                  return CSItemsCard(product: product);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}