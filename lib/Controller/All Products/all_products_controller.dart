import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../Data/Repositories/Product/product_repository.dart';
import '../../Model/product_model.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();
  final productRepository = Get.put(ProductRepository());
  final isLoading = false.obs;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  var searchedProducts = <ProductModel>[].obs;
  final searchController = TextEditingController();

  //Fetch Product By Query
  Future<List<ProductModel>> fetchProductByQuery(Query? query) async {
    try {
      if (query == null) return [];
      final products = await productRepository.fetchProductByQuery(query);
      return products;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  //Fetch Product By Category
  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    try {
      isLoading.value = true;
      final products = await productRepository.fetchProductsByCategory(
        category,
      );
      assignProducts(products);
      return products;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception('Error fetching products by category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  //Sort Products
  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;
    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Highest price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lowest price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      default:
        products.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  //Assign Products
  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts('Name');
  }

  // Fetch all products
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('Products').get();
      final allProducts =
          querySnapshot.docs
              .map((doc) => ProductModel.fromQuerySnapshot(doc))
              .toList();
      return allProducts;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  // Search products by name or category
  void searchProducts(String query) {
    try {
      isLoading.value = true;
      fetchAllProducts().then((allProducts) {
        searchedProducts.value =
            allProducts.where((product) {
              return product.name.toLowerCase().contains(query.toLowerCase()) ||
                  product.category.toLowerCase().contains(query.toLowerCase());
            }).toList();
        isLoading.value = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void clearSearch() {
    searchController.clear();
    searchedProducts.clear();
  }
}