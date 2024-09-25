// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: (json['id'] as num?)?.toInt(),
      text: json['text'] as String?,
      post: json['post'] == null
          ? null
          : Post.fromJson(json['post'] as Map<String, dynamic>),
      postId: (json['post_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'post': instance.post?.toJson(),
      'post_id': instance.postId,
      'user': instance.user?.toJson(),
      'user_id': instance.userId,
      'created_at': instance.createdAt?.toIso8601String(),
    };
