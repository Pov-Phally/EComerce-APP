import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "category")
  String? category;

  @JsonKey(name: "thumbnail")
  String? thumbnail;

  @JsonKey(name: "images")
  List<String>? images;

  @JsonKey(name: "price")
  double? price;

  @JsonKey(name: "isFeatured")
  bool? isFeatured;

  @JsonKey(name: "colors")
  List<String>? colors;

  @JsonKey(name: "sizes")
  List<String>? sizes;

  Product({
    this.id,
    this.name,
    this.description,
    this.category,
    this.thumbnail,
    this.images,
    this.price,
    this.isFeatured,
    this.colors,
    this.sizes,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}