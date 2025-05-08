import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String name;
  String description;
  double price;
  String thumbnail;
  List<String> images;
  String category;
  bool isFeatured;
  List<String> sizes;
  List<String> colors;
  String? selectedColor;
  String? selectedSize;
  int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.images,
    required this.category,
    required this.isFeatured,
    required this.sizes,
    required this.colors,
    this.selectedColor,
    this.selectedSize,
    this.quantity = 1,
  });

  // Factory method to create an empty product model.
  static ProductModel empty() => ProductModel(
    id: '',
    name: '',
    description: '',
    price: 0.0,
    images: [],
    category: '',
    isFeatured: false,
    sizes: [],
    colors: [],
    thumbnail: '',
  );

  // Method to convert the ProductModel to a JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'thumbnail': thumbnail,
      'price': price,
      'quantity': quantity,
      'images': images,
      'description': description,
      'colors': colors,
      'sizes': sizes,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'isFeatured': isFeatured,
    };
  }

  // Factory method to create a ProductModel from a Firebase document snapshot.
  factory ProductModel.fromQuerySnapshot(
    QueryDocumentSnapshot<Object?> document,
  ) {
    final data = document.data() as Map<String, dynamic>;

    return ProductModel(
      id: document.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      images: List<String>.from(data['images'] ?? []),
      category: data['category'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      sizes: List<String>.from(data['sizes'] ?? []),
      colors: List<String>.from(data['colors'] ?? []),
      thumbnail: data['thumbnail'] ?? '',
    );
  }
  // Factory method to create a ProductModel from a JSON map.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 1,
      images: List<String>.from(json['images'] ?? []),
      description: json['description'] ?? '',
      colors: List<String>.from(json['colors'] ?? []),
      sizes: List<String>.from(json['sizes'] ?? []),
      selectedColor: json['selectedColor'],
      selectedSize: json['selectedSize'],
      isFeatured: json['isFeatured'] ?? false,
    );
  }

  // Method to  check if the product is equal to another product.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}