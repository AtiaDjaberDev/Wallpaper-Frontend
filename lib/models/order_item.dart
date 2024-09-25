import 'package:wallpaper_app/models/order.dart';
import 'package:wallpaper_app/models/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItem {
  OrderItem({
    this.id,
    this.price,
    this.productId,
    this.quantity,
    this.productName,
    this.productPhoto,
    this.createdAt,
    this.products,
  });

  int? id;
  double? price;
  int? quantity;
  @JsonKey(name: "product_name")
  String? productName;
  @JsonKey(name: "product_photo")
  String? productPhoto;
  Post? product;
  Order? order;
  @JsonKey(name: "product_id")
  int? productId;
  @JsonKey(name: "order_id")
  int? orderId;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  List<Post>? products;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
