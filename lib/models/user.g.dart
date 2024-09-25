// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      firebaseUid: json['firebaseUid'] as String?,
      username: json['username'] as String?,
      tel: json['tel'] as String?,
      type: json['type'] as String?,
      password: json['password'] as String?,
      status: json['status'] as String?,
      photo: json['photo'] as String?,
      online: (json['online'] as num?)?.toInt(),
      token: json['token'] as String?,
      accessToken: json['accessToken'] as String?,
      email: json['email'] as String?,
      valid: (json['valid'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    )
      ..latitude = (json['latitude'] as num?)?.toDouble()
      ..longitude = (json['longitude'] as num?)?.toDouble();

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firebaseUid': instance.firebaseUid,
      'username': instance.username,
      'tel': instance.tel,
      'type': instance.type,
      'password': instance.password,
      'status': instance.status,
      'photo': instance.photo,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accessToken': instance.accessToken,
      'online': instance.online,
      'token': instance.token,
      'email': instance.email,
      'valid': instance.valid,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
