import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetail({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order['orderId']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Customer: ${order['Username']}'),
            SizedBox(height: 10),
            Text('Order Date: ${order['orderDate']}'),
            SizedBox(height: 10),
            Text('Total Price: \$${order['totalPrice']}'),
            SizedBox(height: 10),
            Text('Shipping Address:${order['orderAddress']}'),
            SizedBox(height: 10),
            Text('Phone Number: ${order['phoneNumber']}'),
            SizedBox(height: 10),
            Text(
              'Items:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: (order['products'] as List<dynamic>? ?? []).length,
                itemBuilder: (context, index) {
                  final item =
                      (order['products'] as List<dynamic>? ?? [])[index];
                  return ListTile(
                    leading:Image.network(item['thumbnail']),
                    title: Text(item['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quantity: ${item['quantity']}'),
                        Text('Color: ${item['color']}'),
                        Text('Size:${item['size']}'),
                      ],
                    ),
                    trailing: Text('\$${item['price']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}