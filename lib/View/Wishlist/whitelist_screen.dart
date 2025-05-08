import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/Wishlist/wishlist_controller.dart';
import '../../Reusable Widget/cs_gridview.dart';
import '../../Reusable Widget/items_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.put(WishlistController());
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: Obx(() {
        return SingleChildScrollView(
          child: CSGridView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            itemCount: wishlistController.wishlist.length,
            itemBuilder: (context, index) {
              return CSItemsCard(product: wishlistController.wishlist[index]);
            },
          ),
        );
      }),
    );
  }
}