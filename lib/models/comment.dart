import 'package:wallpaper_app/models/post.dart';
import 'package:wallpaper_app/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(explicitToJson: true)
class Comment {
  Comment({
    this.id,
    this.text,
    this.post,
    this.postId,
    this.userId,
    this.user,
    this.createdAt,
  });

  int? id;
  String? text;
  Post? post;
  @JsonKey(name: "post_id")
  int? postId;
  User? user;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "created_at")
  DateTime? createdAt;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
