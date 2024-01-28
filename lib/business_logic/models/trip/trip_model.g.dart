// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
      number: json['number'] as String,
      id: json['id'] as int?,
      bus: Trip.fromBusJson(json['bus']),
      date: json['date'] as String,
      arrival: json['arrival'] as String,
      price: (json['price'] as num).toDouble(),
      from: Trip.fromDestinationJson(json['from']),
      to: Trip.fromDestinationJson(json['to']),
      pickups: json['pickups'] as String?,
      bookings: Trip.fromBookingsJson(json['bookings']),
      seats: json['seats'] as int,
      chairStatus: (json['chairStatus'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'bookings': instance.bookings,
      'seats': instance.seats,
      'number': instance.number,
      'bus': instance.bus,
      'date': instance.date,
      'arrival': instance.arrival,
      'price': instance.price,
      'from': instance.from,
      'to': instance.to,
      'pickups': instance.pickups,
      'id': instance.id,
      'chairStatus': instance.chairStatus,
    };
