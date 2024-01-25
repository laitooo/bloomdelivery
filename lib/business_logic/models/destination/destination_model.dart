import 'dart:core';

import 'package:bloomdeliveyapp/business_logic/models/bus/bus_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'destination_model.g.dart';

@JsonSerializable(nullable: true)
class Destination {
  String? name;
  int? id;

  Destination({
    required this.name,
    this.id,
  });
  factory Destination.fromJson(Map<String, dynamic> json) =>
      _$DestinationFromJson(json);
  Map<String, dynamic> toJson() => _$DestinationToJson(this);

  static fromBusJson(json) {
    if (json == null) return null;
    json['data']['attributes']['id'] = json['data']['id'];
    return Bus.fromJson(json['data']['attributes']);
  }
}
