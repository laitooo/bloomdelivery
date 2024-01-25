import 'dart:core';

import 'package:bloomdeliveyapp/business_logic/models/booking/booking_model.dart';
import 'package:bloomdeliveyapp/business_logic/models/bus/bus_model.dart';
import 'package:bloomdeliveyapp/business_logic/models/destination/destination_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trip_model.g.dart';

@JsonSerializable(nullable: true)
class Trip {
  /* String name; */
  @JsonKey(fromJson: fromBookingsJson)
  List<Booking> bookings;
  int seats;
  String number;
  @JsonKey(fromJson: fromBusJson)
  Bus? bus;
  /* @JsonKey(fromJson: fromDateJson) */
  String date;
  String arrival;
  double price;
  @JsonKey(fromJson: fromDestinationJson)
  String from;
  @JsonKey(fromJson: fromDestinationJson)
  String to;
  String? pickups;

  /* @JsonKey(fromJson: fromIdJson) */
  int? id;
  List<List<int>>? chairStatus;
  Trip({
    /* required this.name, */
    /* required this.seats, */
    required this.number,
    this.id,
    this.bus,
    required this.date,
    required this.arrival,
    required this.price,
    required this.from,
    required this.to,
    required this.pickups,
    required this.bookings,
    required this.seats,
    this.chairStatus,
  });
  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
  Map<String, dynamic> toJson() => _$TripToJson(this);

  static fromBusJson(json) {
    if (json == null) return null;
    json['data']['attributes']['id'] = json['data']['id'];
    return Bus.fromJson(json['data']['attributes']);
  }

  static fromBookingsJson(json) {
    List<Booking> bookings = [];
    if (json != null)
      for (var booking in json['data']) {
        booking['attributes']['id'] = booking['id'];
        bookings.add(Booking.fromJson(booking['attributes']));
      }
    return bookings;
  }

  static fromDestinationJson(json) {
    if (json == null) return null;
    json['data']['attributes']['id'] = json['data']['id'];
    return Destination.fromJson(json['data']['attributes']).name;
  }
  /*  static fromDateJson(json) {
    var date = json['date'];
    print(date);
    return json['date'] as String;
    return Bus.fromJson(json['data']['attributes']);
  } */
}

/*     (json['data'] as List<dynamic>).map((e) {
      e['attributes']['id'] = e['id'];
      return Booking.fromJson(e['attributes']);
    }).toList();
    return json['data'];
  }
} */
