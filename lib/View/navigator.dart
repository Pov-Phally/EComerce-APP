import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Home/home_screen.dart';
import 'Setting/setting_screen.dart';
import 'Store/store_screen.dart';
import 'Wishlist/whitelist_screen.dart';


class ScreenNavigator extends StatelessWidget {
  ScreenNavigator({super.key});
  final controller = NavController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: controller._selectIndex.value,
          onDestinationSelected: (index) {
            controller._selectIndex.value = index;
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
              icon: Icon(Icons.store_sharp),
              label: 'Store',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite),
              label: 'Wishlist',
            ),
            NavigationDestination(icon: Icon(Icons.person), label: 'Setting'),
          ],
        );
      }),
      body: Obx(() => controller._screen[controller._selectIndex.value]),
    );
  }
}

class NavController extends GetxController {
  final _selectIndex = 0.obs;
  final _screen =
      [HomeScreen(), StoreScreen(), WishlistScreen(), SettingScreen()].obs;
}