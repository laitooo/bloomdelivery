// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      id: json['id'] as int?,
      seat: json['seat'] as int,
      trip: Booking.fromTripJson(json['trip']),
      ticket: json['ticket'] as String,
      payment: json['payment'] as String,
      cancel: json['cancel'] as bool?,
      user: Booking.fromUserJson(json['user']),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'seat': instance.seat,
      'trip': instance.trip,
      'ticket': instance.ticket,
      'payment': instance.payment,
      'cancel': instance.cancel,
      'id': instance.id,
      'user': instance.user,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
