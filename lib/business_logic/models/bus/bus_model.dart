import 'package:json_annotation/json_annotation.dart';

part 'bus_model.g.dart';

@JsonSerializable(nullable: true)
class Bus {
  String name;
  int seats;
  String plate;
  int id;

  Bus({
    required this.name,
    required this.seats,
    required this.plate,
    required this.id,
  });
  factory Bus.fromJson(Map<String, dynamic> json) => _$BusFromJson(json);
  Map<String, dynamic> toJson() => _$BusToJson(this);
}
