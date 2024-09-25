import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

@JsonSerializable(explicitToJson: true)
class Setting {
  Setting({this.id, this.tel, this.createdAt});

  int? id;
  String? tel;
  String? email;

  @JsonKey(name: "created_at")
  DateTime? createdAt;

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);
  Map<String, dynamic> toJson() => _$SettingToJson(this);
}
