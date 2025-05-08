// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  category: json['category'] as String?,
  thumbnail: json['thumbnail'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  price: (json['price'] as num?)?.toDouble(),
  isFeatured: json['isFeatured'] as bool?,
  colors: (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList(),
  sizes: (json['sizes'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'category': instance.category,
  'thumbnail': instance.thumbnail,
  'images': instance.images,
  'price': instance.price,
  'isFeatured': instance.isFeatured,
  'colors': instance.colors,
  'sizes': instance.sizes,
};