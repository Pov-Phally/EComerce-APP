import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Model/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'dd/MM/yy hh:mm a',
    ).format(order.orderDate);

    return Scaffold(
      appBar: AppBar(title: Text('Order Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: order.products.length,
              itemBuilder: (context, index) {
                final product = order.products[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                product.thumbnail,
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Color: ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: product.color,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Size: ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: product.size,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Quantity: ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${product.quantity}',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                            children: [
                              TextSpan(text: '\$'),
                              TextSpan(text: product.price.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Text('Order ID: ${order.orderId}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Order Date: $formattedDate', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(
              'Order Address: ${order.orderAddress}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Order Status: ${order.orderStatus}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Total Price: \$${order.totalPrice}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}