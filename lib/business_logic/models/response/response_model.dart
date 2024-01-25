import 'package:json_annotation/json_annotation.dart';
import 'package:bloomdeliveyapp/business_logic/models/response/response_error_message_model.dart';

part 'response_model.g.dart';

@JsonSerializable(nullable: true)
class ResponseModel {
  int? statusCode;
  String? error;
  ResponseErrorMeessageModel? message;
  dynamic data;
  ResponseModel({
    this.statusCode,
    this.error,
    this.message,
    this.data,
  });
  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
