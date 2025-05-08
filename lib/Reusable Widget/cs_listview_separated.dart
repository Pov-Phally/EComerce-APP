import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/Cart/cart_controller.dart';

class CSListViewSeparated extends StatelessWidget {
  const CSListViewSeparated({super.key, required this.cartController});

  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, index) => SizedBox(height: 20),
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) {
          final product = cartController.cartItems[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                          image: DecorationImage(
                            image: NetworkImage(product.images[0]),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Color: ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: product.selectedColor,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Size: ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: product.selectedSize,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          cartController.removeFromCart(product);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              cartController.decrementQuantity(product);
                            },
                            icon: Icon(Icons.remove, color: Colors.grey),
                          ),
                          Text(
                            '${product.quantity}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cartController.incrementQuantity(product);
                            },
                            icon: Icon(
                                Icons.add, color: Colors.deepPurpleAccent),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                          children: [
                            TextSpan(text: '\$'),
                            TextSpan(text: product.price.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}