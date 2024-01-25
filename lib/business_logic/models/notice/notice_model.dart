import 'package:bloomdeliveyapp/business_logic/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notice_model.g.dart';

@JsonSerializable()
class Notice {
  String description;
  String formattedAddress;
  Latlng latlng;
  int? id;
  bool? status;
  @JsonKey(ignore: true)
  User? user;
  @JsonKey(ignore: true)
  int? userId;
  String type;
  String? createdAt;
  String? updatedAt;
  Notice({
    required this.description,
    required this.formattedAddress,
    required this.latlng,
    this.status,
    //required this.id,
    //required this.user,
    required this.type,
    this.createdAt,
    this.updatedAt,
  });
  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeToJson(this);

  static _writeId() {}

  /* static _writeLatLng(List<dynamic> value) {
    

  } */
}

@JsonSerializable()
class Latlng {
  double lat;
  double lng;
  Latlng({required this.lat, required this.lng});
  factory Latlng.fromJson(Map<String, dynamic> json) => _$LatlngFromJson(json);
  Map<String, dynamic> toJson() => _$LatlngToJson(this);
}
