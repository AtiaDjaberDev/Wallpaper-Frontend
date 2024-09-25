import 'package:wallpaper_app/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_item.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  Order({
    this.id,
    this.price,
    this.discount,
    this.createdAt,
    this.user,
    this.userId,
    this.boy,
    this.boyId,
    this.status,
    this.orderItems,
  });

  int? id;
  double? price;
  User? user;
  @JsonKey(name: "user_id")
  int? userId;
  User? boy;
  @JsonKey(name: "boy_id")
  int? boyId;
  double? discount;
  @JsonKey(name: "created_at")
  String? createdAt;
  String? status;
  @JsonKey(name: "order_items")
  List<OrderItem>? orderItems;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
