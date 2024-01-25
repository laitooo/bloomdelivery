// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bus _$BusFromJson(Map<String, dynamic> json) => Bus(
      name: json['name'] as String,
      seats: json['seats'] as int,
      plate: json['plate'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$BusToJson(Bus instance) => <String, dynamic>{
      'name': instance.name,
      'seats': instance.seats,
      'plate': instance.plate,
      'id': instance.id,
    };
