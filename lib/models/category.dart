import 'package:wallpaper_app/models/section.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  Category({
    this.id,
    this.name,
    this.photo,
    this.description,
    this.isSelected,
    required this.sections,
  });

  int? id;
  String? name;
  int? position;
  bool? isSelected;
  String? photo;
  @JsonKey(defaultValue: [])
  List<Section> sections;
  String? description;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
