// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice(
      description: json['description'] as String,
      formattedAddress: json['formattedAddress'] as String,
      latlng: Latlng.fromJson(json['latlng'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      type: json['type'] as String,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    )..id = json['id'] as int?;

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'description': instance.description,
      'formattedAddress': instance.formattedAddress,
      'latlng': instance.latlng,
      'id': instance.id,
      'status': instance.status,
      'type': instance.type,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Latlng _$LatlngFromJson(Map<String, dynamic> json) => Latlng(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LatlngToJson(Latlng instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
