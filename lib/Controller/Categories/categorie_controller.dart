import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../Data/Repositories/Categories/categories_repository.dart';
import '../../Model/categorie_model.dart';

class CategoriesController extends GetxController {
  static CategoriesController get instance => Get.find();
  final isLoading = false.obs;
  final _categoriesRepository = Get.put(CategoriesRepository());
  RxList<CategoriesModel> allCategories = <CategoriesModel>[].obs;
  RxList<CategoriesModel> featuredCategories = <CategoriesModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  //Fetch all categories
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final categories = await _categoriesRepository.getAllCategories();
      categories.sort((a, b) => a.name.compareTo(b.name));
      allCategories.assignAll(categories);
      featuredCategories.assignAll(
        allCategories
            .where(
              (category) => category.isFeatured && category.parentId.isEmpty,
            )
            .take(8)
            .toList(),
      );
    } catch (e) {
      if (kDebugMode) {}
    } finally {
      isLoading.value = false;
    }
  }
}