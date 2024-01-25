import 'package:json_annotation/json_annotation.dart';
import 'package:bloomdeliveyapp/business_logic/models/response/response_error_messages_model.dart';

part 'response_error_message_model.g.dart';

@JsonSerializable(nullable: true)
class ResponseErrorMeessageModel {
  List<ResponseErrorMeessagesModel>? messages;
  ResponseErrorMeessageModel({
    this.messages,
  });
  factory ResponseErrorMeessageModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseErrorMeessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseErrorMeessageModelToJson(this);
}
