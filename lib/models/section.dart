import 'package:wallpaper_app/models/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section.g.dart';

@JsonSerializable(explicitToJson: true)
class Section {
  Section(
      {this.id,
      this.name,
      this.photo,
      this.description,
      this.categoryId,
      this.category});

  int? id;
  String? name;
  String? photo;
  String? description;
  bool? isSelected;

  @JsonKey(name: "category_id")
  int? categoryId;
  Category? category;

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);
  Map<String, dynamic> toJson() => _$SectionToJson(this);
}
