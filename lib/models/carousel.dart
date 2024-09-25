// To parse this JSON data, do
//
//     final Slider = SliderFromJson(jsonString);

import 'package:wallpaper_app/models/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'carousel.g.dart';

@JsonSerializable()
class Carousel {
  Carousel({
    this.id,
    this.name,
    this.photo,
    this.target,
    this.active,
    this.createdAt,
  });

  int? id;
  String? photo;
  String? target;
  String? name;
  Category? category;
  @JsonKey(name: "category_id")
  int? categoryId;
  DateTime? createdAt;
  bool? active;

  factory Carousel.fromJson(Map<String, dynamic> json) =>
      _$CarouselFromJson(json);
  Map<String, dynamic> toJson() => _$CarouselToJson(this);
}
