// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      photo: json['photo'] as String?,
      visible: (json['visible'] as num?)?.toInt(),
      description: json['description'] as String?,
      address: json['address'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      attachment: json['attachment'] as String?,
      sectionId: (json['sectionId'] as num?)?.toInt(),
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      comments_count: (json['comments_count'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..available = (json['available'] as num?)?.toInt()
      ..sections = (json['sections'] as List<dynamic>?)
              ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
              .toList() ??
          []
      ..downloadProgress = (json['downloadProgress'] as num?)?.toDouble();

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'photo': instance.photo,
      'visible': instance.visible,
      'description': instance.description,
      'address': instance.address,
      'category_id': instance.categoryId,
      'category': instance.category?.toJson(),
      'user_id': instance.userId,
      'sectionId': instance.sectionId,
      'available': instance.available,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'categories': instance.categories.map((e) => e.toJson()).toList(),
      'sections': instance.sections.map((e) => e.toJson()).toList(),
      'comments_count': instance.comments_count,
      'user': instance.user?.toJson(),
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
      'attachment': instance.attachment,
      'downloadProgress': instance.downloadProgress,
    };
