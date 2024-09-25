// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: (json['id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      productId: (json['product_id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      productName: json['product_name'] as String?,
      productPhoto: json['product_photo'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..product = json['product'] == null
          ? null
          : Post.fromJson(json['product'] as Map<String, dynamic>)
      ..order = json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>)
      ..orderId = (json['order_id'] as num?)?.toInt();

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'quantity': instance.quantity,
      'product_name': instance.productName,
      'product_photo': instance.productPhoto,
      'product': instance.product?.toJson(),
      'order': instance.order?.toJson(),
      'product_id': instance.productId,
      'order_id': instance.orderId,
      'created_at': instance.createdAt?.toIso8601String(),
      'products': instance.products?.map((e) => e.toJson()).toList(),
    };
