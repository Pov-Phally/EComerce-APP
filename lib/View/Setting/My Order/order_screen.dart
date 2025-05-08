import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Controller/Order List/order_controller.dart';
import '../../../Model/order_model.dart';
import 'order_items_details.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: FutureBuilder<List<OrderModel>>(
        future: orderController.fetchUserOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final formattedDate = DateFormat(
                  'dd/MM/yy hh:mm a',
                ).format(order.orderDate);
                return Card(
                  child: ListTile(
                    title: Text('Order ID: ${order.orderId}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Amount: \$${order.totalPrice}'),
                        Text('Status: ${order.orderStatus}'),
                        Text('Order Date: $formattedDate'),
                      ],
                    ),
                    onTap: () {
                      Get.to(() => OrderDetailScreen(order: order));
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}