// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) =>
    ResponseModel(
      statusCode: json['statusCode'] as int?,
      error: json['error'] as String?,
      message: json['message'] == null
          ? null
          : ResponseErrorMeessageModel.fromJson(
              json['message'] as Map<String, dynamic>),
      data: json['data'],
    );

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };
