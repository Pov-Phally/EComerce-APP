import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_online_store/Model/product_model.dart';
import 'package:kh_online_store/View/Detail%20Screen/product_detail_screen.dart';

import '../Controller/Wishlist/wishlist_controller.dart';

class CSItemsCard extends StatelessWidget {
  CSItemsCard({super.key, required this.product});
  final ProductModel product;

  final wishlistController = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailScreen(product: product));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.45,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.deepPurpleAccent),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Products images
              Container(
                height: MediaQuery.sizeOf(context).height * 0.13,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(product.thumbnail),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                //favorite icon
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() {
                          bool isWishlist = wishlistController.isWishlist(
                            product,
                          );
                          return IconButton(
                            onPressed: () {
                              wishlistController.toggleWishlist(product);
                            },
                            icon: Icon(
                              isWishlist
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isWishlist ? Colors.red : Colors.grey,
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              //product title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  product.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              //product subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(
                  spacing: 5,
                  children: [
                    Text(
                      product.category,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Colors.blueAccent,
                      size: 13,
                    ),
                  ],
                ),
              ),
              Spacer(),
              //product price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(text: '\$ '),
                      TextSpan(text: product.price.toString()),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}