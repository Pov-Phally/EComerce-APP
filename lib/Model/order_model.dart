import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents an order with its details.
class OrderModel {
  final String id;
  final String orderId;
  late final DateTime orderDate;
  final String orderAddress;
  final String orderStatus;
  final double totalPrice;
  final String phoneNumber;
  final List<ProductModel> products;

  OrderModel({
    required this.id,
    required this.orderId,
    required this.orderDate,
    required this.orderAddress,
    required this.orderStatus,
    required this.totalPrice,
    required this.products,
    required this.phoneNumber,
  });

  /// Creates an instance of [OrderModel] from a JSON object.
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      orderId: json['orderId'],
      orderDate: DateTime.parse(json['orderDate']),
      orderAddress: json['orderAddress'],
      orderStatus: json['orderStatus'],
      totalPrice: json['totalPrice'],
      products:
          (json['products'] as List)
              .map((product) => ProductModel.fromJson(product))
              .toList(),
      phoneNumber:  json['phoneNumber'],
    );
  }

  /// Converts the [OrderModel] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'orderDate': orderDate.toIso8601String(),
      'orderAddress': orderAddress,
      'orderStatus': orderStatus,
      'totalPrice': totalPrice,
      'phoneNumber': phoneNumber,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  /// Factory method to create an [OrderModel] from a Firebase document snapshot.
  factory OrderModel.fromQuerySnapshot(
    QueryDocumentSnapshot<Object?> document,
  ) {
    final data = document.data() as Map<String, dynamic>;
    return OrderModel(
      id: document.id,
      orderId: data['orderId'],
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      orderAddress: data['orderAddress'],
      orderStatus: data['orderStatus'],
      totalPrice: data['totalPrice'],
      phoneNumber: data['phoneNumber'],
      products:
          (data['products'] as List)
              .map((product) => ProductModel.fromJson(product))
              .toList(),
    );
  }
}

/// Represents a product in an order.
class ProductModel {
  final String name;
  final String size;
  final String color;
  final double price;
  final int quantity;
  final String thumbnail;

  ProductModel({
    required this.name,
    required this.size,
    required this.color,
    required this.price,
    required this.quantity,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] ?? '',
      size: json['size'] ?? '',
      color: json['color'] ?? '',
      price: json['price'] ?? 0.0,
      quantity: json['quantity'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
    );
  }
  factory ProductModel.fromQuerySnapshot(
    QueryDocumentSnapshot<Object?> document,
  ) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      name: data['name'] ?? '',
      size: data['size'] ?? '',
      color: data['color'] ?? '',
      price: data['price'] ?? 0.0,
      quantity: data['quantity'] ?? 0,
      thumbnail: data['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'size': size,
      'color': color,
      'price': price,
      'quantity': quantity,
      'thumbnail': thumbnail,
    };
  }
}