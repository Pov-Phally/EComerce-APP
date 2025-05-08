import 'package:get/get.dart';
import 'package:kh_online_store_admin/View/add_products.dart';
import 'package:kh_online_store_admin/View/dashboard.dart';

import '../View/Order.dart';

class NavController extends GetxController {
  final selectIndex = 0.obs;
  final screen = [Dashboard(), AddProducts(),CustomerOrders()].obs;
}