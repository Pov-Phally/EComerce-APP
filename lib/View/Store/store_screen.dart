import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/All Products/all_products_controller.dart';
import '../../Controller/Categories/categorie_controller.dart';
import '../../Model/product_model.dart';
import '../../Reusable Widget/cs_gridview.dart';
import '../../Reusable Widget/cs_search_bar.dart';
import '../../Reusable Widget/items_card.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen({super.key});
  final categoryController = Get.put(CategoriesController());
  @override
  Widget build(BuildContext context) {
    final productController = Get.put(AllProductsController());
    return DefaultTabController(
      length: categoryController.allCategories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Store'),
          backgroundColor: Colors.white,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxScroll) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                expandedHeight: 150,
                flexibleSpace: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: 26),
                    //Search Bar
                    CSSearchBar(),
                  ],
                ),
                //Tab Bar titles
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Container(
                    color: Colors.white,
                    child: TabBar(
                      indicatorColor: Colors.deepPurpleAccent,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs:
                          categoryController.allCategories
                              .map(
                                (category) => Tab(child: Text(category.name)),
                              )
                              .toList(),
                    ),
                  ),
                ),
              ),
            ];
          },
          // TabBar View Detail
          body: TabBarView(
            children:
                categoryController.allCategories.map((category) {
                  return FutureBuilder<List<ProductModel>>(
                    future: productController.fetchProductsByCategory(
                      category.name,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No products found'));
                      } else {
                        final products = snapshot.data!;
                        return CSGridView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          itemCount: products.length,
                          itemBuilder: (_, index) {
                            return CSItemsCard(product: products[index]);
                          },
                        );
                      }
                    },
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}