import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_online_store/Model/product_model.dart';
import 'package:kh_online_store/Reusable%20Widget/items_card.dart';

import '../Controller/All Products/all_products_controller.dart';
import 'cs_gridview.dart';

class CSSortableProduct extends StatelessWidget {
  const CSSortableProduct({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          DropdownButtonFormField(
            value: controller.selectedSortOption.value,
            onChanged: (value) {
              controller.sortProducts(value!);
            },
            items:
                ['Name', 'Lowest price', 'Highest price']
                    .map(
                      (option) =>
                          DropdownMenuItem(value: option, child: Text(option)),
                    )
                    .toList(),
          ),
          SizedBox(height: 20),
          Obx(() {
            return CSGridView(
              itemCount: controller.products.length,
              itemBuilder:
                  (_, index) =>
                      CSItemsCard(product: controller.products[index]),
            );
          }),
        ],
      ),
    );
  }
}