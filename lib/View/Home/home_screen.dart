import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kh_online_store/Reusable%20Widget/cs_appbar.dart';

import '../../Controller/Categories/categorie_controller.dart';
import '../../Controller/Feature Product/feature_product_controller.dart';
import '../../Controller/User/user_controller.dart';
import '../../Reusable Widget/cs_gridview.dart';
import '../../Reusable Widget/cs_search_bar.dart';
import '../../Reusable Widget/home_screen_cover_slide.dart';
import '../../Reusable Widget/items_card.dart';
import '../All Product/all_feature_products_screen.dart';
import '../All Product/product_by_category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final categoryController = Get.put(CategoriesController());
    final featureProductController = Get.put(FeatureProductController());
    return Scaffold(
      body: SingleChildScrollView(
        physics: PageScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(0),
          color: Colors.deepPurpleAccent,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height,
                    width: double.infinity,
                    padding: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //App bar
                        Obx(() {
                          return CSAppBar(
                            upText: 'Enjoy your shopping,',
                            downText: controller.user.value.username,
                          );
                        }),
                        //search bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CSSearchBar(),
                        ),

                        SizedBox(height: 15),
                        //category
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Feature Category',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 25,
                          ),
                          child: Obx(() {
                            if (categoryController.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (categoryController.featuredCategories.isEmpty) {
                              return Center(child: Text('No Categories Found'));
                            }
                            return Container(
                              padding: EdgeInsets.all(0),
                              height: 50,
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount:
                                    categoryController
                                        .featuredCategories
                                        .length,
                                itemBuilder:
                                    (context, index) => GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => ProductByCategoryScreen(
                                            title:
                                                categoryController
                                                    .featuredCategories[index]
                                                    .name,
                                            category:
                                                categoryController
                                                    .featuredCategories[index]
                                                    .name,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        margin: EdgeInsets.only(
                                          right: 10,
                                          left: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            categoryController
                                                .featuredCategories[index]
                                                .name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                scrollDirection: Axis.horizontal,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  //Second container for products
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.33,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        //Cover slider
                        CSCoverSlider(),
                        //Feature products tittle
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text(
                                'Feature Products',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  Get.to(
                                    () => AllFeatureProductsScreen(
                                      title: 'Popular Products',
                                      futureMethod:
                                          featureProductController
                                              .fetchAllFeatureProduct(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'See All',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Feature products
                        Obx(() {
                          if (featureProductController.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (featureProductController.featureProduct.isEmpty) {
                            return Center(child: Text('No Products Found'));
                          }
                          return CSGridView(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            itemCount:
                                featureProductController.featureProduct.length,
                            itemBuilder:
                                (context, index) => CSItemsCard(
                                  product:
                                      featureProductController
                                          .featureProduct[index],
                                ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}