import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    this.id,
    this.firebaseUid,
    this.username,
    this.tel,
    this.type,
    this.password,
    this.status,
    this.photo,
    this.online,
    this.token,
    this.accessToken,
    this.email,
    this.valid,
    this.createdAt,
  });

  int? id;
  String? firebaseUid;
  String? username;

  String? tel;
  String? type;
  String? password;
  String? status;
  String? photo;
  double? latitude;
  double? longitude;

  // @JsonKey(includeToJson: false)
  String? accessToken;
  int? online;
  String? token;
  String? email;
  int? valid;
  DateTime? createdAt;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
