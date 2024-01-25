import 'package:json_annotation/json_annotation.dart';

part 'response_error_messages_model.g.dart';

@JsonSerializable(nullable: true)
class ResponseErrorMeessagesModel {
  String? id;
  String? message;
  ResponseErrorMeessagesModel({
    this.id,
    this.message,
  });
   factory ResponseErrorMeessagesModel.fromJson(Map<String, dynamic> json) => _$ResponseErrorMeessagesModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseErrorMeessagesModelToJson(this);
}