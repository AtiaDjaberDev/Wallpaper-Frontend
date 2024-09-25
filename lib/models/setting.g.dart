// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting(
      id: (json['id'] as num?)?.toInt(),
      tel: json['tel'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    )..email = json['email'] as String?;

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'id': instance.id,
      'tel': instance.tel,
      'email': instance.email,
      'created_at': instance.createdAt?.toIso8601String(),
    };
