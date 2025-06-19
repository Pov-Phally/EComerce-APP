import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../View/Cart/cart.dart';

class CSAppBar extends StatelessWidget {
  final String? upText;
  final String? downText;
  const CSAppBar({super.key, this.upText, this.downText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                upText ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white60,
                ),
              ),
              Text(
                downText ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Get.to(() => CartScreen());
          },
        ),
      ],
    );
  }
}