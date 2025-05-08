import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../Data/Repositories/Product/product_repository.dart';
import '../../Model/product_model.dart';

class FeatureProductController extends GetxController {
  static FeatureProductController get instance => Get.find();
  RxList<ProductModel> featureProduct = <ProductModel>[].obs;
  final productRepository = Get.put(ProductRepository());
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchFeatureProduct();
    super.onInit();
  }

  //Fetch Feature Product
  Future<void> fetchFeatureProduct() async {
    try {
      isLoading.value = true;
      final products = await productRepository.getFeatureProduct();
      featureProduct.assignAll(products);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  //Fetch All Feature Product
  Future<List<ProductModel>> fetchAllFeatureProduct() async {
    try {
      final products = await productRepository.getFeatureProduct();
      return products;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}