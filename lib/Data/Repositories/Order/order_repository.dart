import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../Model/order_model.dart';
import '../User/user_repository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = UserRepository.instance.authUser!.uid;
      if (userId.isEmpty) throw ('User not found');
      final result =
          await _db.collection('users').doc(userId).collection('orders').get();
      return result.docs.map((e) => OrderModel.fromJson(e.data())).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    throw ('Something went wrong');
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      final docRef = await _db
          .collection('users')
          .doc(userId)
          .collection('orders')
          .add(order.toJson());
      await docRef.update({'id': docRef.id});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw ('Something went wrong');
    }
  }
}