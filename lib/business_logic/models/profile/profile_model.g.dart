// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      email: json['email'] as String,
      username: json['username'] as String,
      id: json['id'] as int,
      phone: json['phone'] as String,
      fullname: json['fullname'] as String,
      confirmedPhone: json['confirmedPhone'] as bool,
      otp: json['otp'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'id': instance.id,
      'phone': instance.phone,
      'fullname': instance.fullname,
      'confirmedPhone': instance.confirmedPhone,
      'otp': instance.otp,
    };
