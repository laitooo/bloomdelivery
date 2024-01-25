import 'package:bloomdeliveyapp/business_logic/models/trip/trip_model.dart';
import 'package:bloomdeliveyapp/business_logic/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable(nullable: true)
class Booking {
  String name;
  String phone;
  String address;
  int seat;
  @JsonKey(fromJson: fromTripJson)
  Trip? trip;
  String ticket;
  String payment;
  bool? cancel;
  int? id;
  @JsonKey(fromJson: fromUserJson)
  User? user;
  String? createdAt;
  String? updatedAt;
  Booking({
    required this.name,
    required this.phone,
    required this.address,
    this.id,
    required this.seat,
    required this.trip,
    required this.ticket,
    required this.payment,
    this.cancel,
    required this.user,
    this.createdAt,
    this.updatedAt,
  });
  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);

  static fromTripJson(json) {
    if (json == null) return null;
    if (json['data'] != null) {
      json['data']['attributes']['id'] = json['data']['id'];

      ///print(json['data']['attributes']);
      return Trip.fromJson(json['data']['attributes']);
    } else {
      /*  json['data']['attributes']['id'] = json['data']['id']; */
      ///print(json['data']['attributes']);
      return Trip.fromJson(json);
    }
  }

  static fromUserJson(json) {
    if (json == null) return null;
    if (json['data'] != null) {
      json['data']['attributes']['id'] = json['data']['id'];
      return User.fromJson(json['data']['attributes']);
    } else {
      //json['data']['attributes']['id'] = json['data']['id'];
      return User.fromJson(json);
    }
  }
}
