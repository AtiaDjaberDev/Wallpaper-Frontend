// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      title: json['title'] as String?,
      address: json['address'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      locationId: (json['location_id'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      sectionId: (json['section_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      from: json['from'] as String?,
      to: json['to'] as String?,
    )
      ..postId = (json['post_id'] as num?)?.toInt()
      ..nextPage = (json['nextPage'] as num?)?.toInt()
      ..prevPage = (json['prevPage'] as num?)?.toInt()
      ..itemCount = (json['itemCount'] as num?)?.toInt();

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'title': instance.title,
      'address': instance.address,
      'category_id': instance.categoryId,
      'post_id': instance.postId,
      'nextPage': instance.nextPage,
      'prevPage': instance.prevPage,
      'itemCount': instance.itemCount,
      'status': instance.status,
      'page': instance.page,
      'user_id': instance.userId,
      'section_id': instance.sectionId,
      'location_id': instance.locationId,
      'from': instance.from,
      'to': instance.to,
    };
