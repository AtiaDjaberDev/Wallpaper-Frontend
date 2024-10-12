// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'package:wallpaper_app/models/image.dart';
import 'package:wallpaper_app/models/section.dart';
import 'package:json_annotation/json_annotation.dart';

import 'category.dart';
import 'user.dart';
part 'post.g.dart';

bool toBool(int? status) {
  if (status == null) return false;
  return status == 1;
}

int toNumber(bool? status) {
  if (status == null) return 0;
  return status ? 1 : 0;
}

@JsonSerializable(explicitToJson: true)
class Post {
  Post({
    this.id,
    this.title,
    this.photo,
    this.visible,
    this.description,
    this.address,
    this.userId,
    this.categoryId,
    this.attachment,
    this.sectionId,
    required this.categories,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.comments_count,
    this.user,
    this.attachments,
  }) : sections = [];

  int? id;
  String? title;
  String? photo;
  int? visible;

  String? description;
  String? address;

  @JsonKey(name: "category_id")
  int? categoryId;
  Category? category;

  @JsonKey(name: "user_id")
  int? userId;
  int? sectionId;

  int? available;

  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(defaultValue: [])
  List<Category> categories;
  @JsonKey(defaultValue: [])
  List<Section> sections;
  int? comments_count;
  User? user;
  List<Attachment>? attachments;
  String? attachment;
  double? downloadProgress;
  double? shareProgress;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
