import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/orders_controller.dart';
import 'oder_detail.dart';

class CustomerOrders extends StatelessWidget {
  final controller = Get.put(OrdersController());

  CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchUserOrders(); // Fetch orders on screen load

    return Scaffold(
      appBar: AppBar(title: Text('Customer Orders')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.userOrders.isEmpty) {
          return Center(child: Text('No orders found.'));
        }
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchUserOrders();
          },
          child: ListView.builder(
            itemCount: controller.userOrders.length,
            itemBuilder: (context, index) {
              final order = controller.userOrders[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => OrderDetail(order: order));
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('Order ID: ${order['orderId']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Customer: ${order['Username']}'),
                        Text('Date: ${order['orderDate']}'),
                      ],
                    ),
                    trailing: Text('Total: \$${order['totalPrice']}'),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}