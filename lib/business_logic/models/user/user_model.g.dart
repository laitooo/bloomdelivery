// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String?,
      id: json['id'] as int,
      phone: json['phone'] as String,
      fullname: json['fullname'] as String,
      confirmedPhone: json['confirmedPhone'] as bool,
      otp: json['otp'] as String?,
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'id': instance.id,
      'phone': instance.phone,
      'fullname': instance.fullname,
      'confirmedPhone': instance.confirmedPhone,
      'otp': instance.otp,
      'wallet': instance.wallet,
      'type': instance.type,
    };
