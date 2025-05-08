import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/nav_controller.dart';

class NavigatorScreen extends StatelessWidget {
  const NavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavController());
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.selectIndex.value,
          onTap: (index) {
            controller.selectIndex.value = index;
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'DashBoard'),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              label: 'Order',
            ),
          ],
        );
      }),
      body: Obx(() => controller.screen[controller.selectIndex.value]),
    );
  }
}