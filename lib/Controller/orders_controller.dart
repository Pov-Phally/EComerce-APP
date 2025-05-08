import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersController extends GetxController {
  var userOrders = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserOrders();
  }

  Future<void> fetchUserOrders() async {
    try {
      FirebaseFirestore.instance.collection('users').snapshots().listen((usersSnapshot) {
            userOrders.clear();
            for (var userDoc in usersSnapshot.docs) {
              userDoc.reference.collection('orders').snapshots().listen((ordersSnapshot) {
                for (var orderDoc in ordersSnapshot.docs) {
                  final orderData = orderDoc.data();
                  final username = userDoc.get('Username');
                  orderData['Username'] = username;

                  // Format the date
                  if (orderData['orderDate'] != null) {
                    final rawDate = DateTime.parse(orderData['orderDate']);
                    orderData['rawDate'] = rawDate;
                    orderData['orderDate'] = DateFormat(
                      'dd/MM/yyyy, hh:mm a',
                    ).format(rawDate);
                  }

                  // Check for duplicates before adding
                  if (!userOrders.any((order) => order['id'] == orderDoc.id)) {
                    orderData['id'] = orderDoc.id;
                    userOrders.add(orderData);
                  }
                }

                // Sort orders by rawDate in descending order
                userOrders.sort(
                      (a, b) =>
                      (b['rawDate'] as DateTime).compareTo(a['rawDate'] as DateTime),
                );
              });
            }
          });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }finally {
      isLoading = false.obs;
      update();
    }
  }
}