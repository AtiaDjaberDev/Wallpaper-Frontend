// To parse this JSON data, do
//
//     final image = imageFromJson(jsonString);

import 'dart:convert';

class Attachment {
  Attachment({
    this.id,
    this.path,
    this.postId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? path;
  int? postId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Attachment.fromRawJson(String str) =>
      Attachment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"] == null ? null : json["id"],
        path: json["path"] == null ? null : json["path"],
        postId: json["post_id"] == null ? null : json["post_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "path": path == null ? null : path,
        "post_id": postId == null ? null : postId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}
