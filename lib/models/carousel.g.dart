// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Carousel _$CarouselFromJson(Map<String, dynamic> json) => Carousel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      target: json['target'] as String?,
      active: json['active'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    )
      ..category = json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>)
      ..categoryId = (json['category_id'] as num?)?.toInt();

Map<String, dynamic> _$CarouselToJson(Carousel instance) => <String, dynamic>{
      'id': instance.id,
      'photo': instance.photo,
      'target': instance.target,
      'name': instance.name,
      'category': instance.category,
      'category_id': instance.categoryId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'active': instance.active,
    };
