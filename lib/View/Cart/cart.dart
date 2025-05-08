import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Cart/cart_controller.dart';
import '../../Reusable Widget/cs_elevated_button.dart';
import '../../Reusable Widget/cs_listview_separated.dart';
import 'Check Out/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: AppBar(
        title: Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CSListViewSeparated(cartController: cartController),
      ),
      bottomNavigationBar: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return SizedBox.shrink();
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: CSElevatedButton(
              text: '\$${cartController.totalPrice}',
              onPressed: () {
                Get.to(() => CheckoutScreen());
              },
            ),
          );
        }
      }),
    );
  }
}