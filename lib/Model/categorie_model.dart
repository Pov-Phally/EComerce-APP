import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  // Factory method to create an empty CategoriesModel.
  static CategoriesModel empty() =>
      CategoriesModel(id: '', name: '', image: '', isFeatured: false);

  // Method to convert the CategoriesModel to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentID': parentId,
      'isFeatured': isFeatured,
    };
  }

  // Factory method to create a CategoriesModel from a Firebase document snapshot.
  factory CategoriesModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoriesModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        parentId: data['ParentID'] ?? '',
      );
    } else {
      return CategoriesModel.empty();
    }
  }
}