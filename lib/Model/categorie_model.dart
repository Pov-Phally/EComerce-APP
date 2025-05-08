import 'package:cloud_firestore/cloud_firestore.dart';
class CategoriesModel{
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
    this.parentId='',
});
  static CategoriesModel empty()=>CategoriesModel(id: '', name: '', image: '', isFeatured: false,);

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentID': parentId,
      'isFeatured': isFeatured,
    };
  }

  factory CategoriesModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if (document.data() != null) {
      final data = document.data()!;

      return CategoriesModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        parentId: data['ParentID'] ?? '',
      );
    }else{
      return CategoriesModel.empty();

    }
  }
  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: '',
      name: json['Name'] ?? '',
      image: json['Image'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      parentId: json['ParentID'] ?? '',
    );
  }

}