import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../Data/Repositories/Order/order_repository.dart';
import '../../Model/order_model.dart';
import '../Address/address_controller.dart';
import '../Cart/cart_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  final orderRepository = Get.put(OrderRepository());
  final addressController = Get.put(AddressController());
  final cartController = Get.put(CartController());


  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}