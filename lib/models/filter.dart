import 'package:json_annotation/json_annotation.dart';
part 'filter.g.dart';

@JsonSerializable()
class Filter {
  String? title;
  String? address;
  @JsonKey(name: "category_id")
  int? categoryId;
  @JsonKey(name: "post_id")
  int? postId;
  int? nextPage;
  int? prevPage;
  int? itemCount;
  int? status;
  int? page;
  List<int>? ids;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "section_id")
  int? sectionId;
  @JsonKey(name: "location_id")
  int? locationId;
  String? from;
  String? to;

  String toQuery() {
    final map = toJson();
    return map.entries
        .where((element) => element.value != null)
        .map((e) => e.value == null ? "" : "${e.key}=${e.value}")
        .join("&");
  }

  Filter(
      {this.title,
      this.address,
      this.categoryId,
      this.page = 1,
      this.locationId,
      this.status,
      this.sectionId,
      this.userId,
      this.from,
      this.to,
      this.ids});

  Map<String, dynamic> toJson() => _$FilterToJson(this);
}
