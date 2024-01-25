// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_error_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseErrorMeessageModel _$ResponseErrorMeessageModelFromJson(
        Map<String, dynamic> json) =>
    ResponseErrorMeessageModel(
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) =>
              ResponseErrorMeessagesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseErrorMeessageModelToJson(
        ResponseErrorMeessageModel instance) =>
    <String, dynamic>{
      'messages': instance.messages,
    };
