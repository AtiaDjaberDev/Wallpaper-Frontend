// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      createdAt: json['created_at'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      userId: (json['user_id'] as num?)?.toInt(),
      boy: json['boy'] == null
          ? null
          : User.fromJson(json['boy'] as Map<String, dynamic>),
      boyId: (json['boy_id'] as num?)?.toInt(),
      status: json['status'] as String?,
      orderItems: (json['order_items'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'user': instance.user?.toJson(),
      'user_id': instance.userId,
      'boy': instance.boy?.toJson(),
      'boy_id': instance.boyId,
      'discount': instance.discount,
      'created_at': instance.createdAt,
      'status': instance.status,
      'order_items': instance.orderItems?.map((e) => e.toJson()).toList(),
    };
