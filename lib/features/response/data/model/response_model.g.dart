// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) {
  return ResponseModel(
    response: json['response'] as String,
    responseId: json['_id'] as String,
    formTemplateId: json['formTemplateId'] as String,
    formTemplateName: json['formTemplateName'] as String,
    formTemplateDescription: json['formTemplateDescription'] as String,
    categoryTemplateId: json['categoryTemplateId'] as String,
    categoryTemplateName: json['categoryTemplateName'] as String,
    categoryTemplateDescription: json['categoryTemplateDescription'] as String,
    questionTemplateId: json['questionTemplateId'] as String,
    questionTemplateQuestion: json['questionTemplateQuestion'] as String,
    questionTemplateOrder: json['questionTemplateOrder'] as int,
    questionTemplateDataType: json['questionTemplateDataType'] as String,
    optionTemplateId: json['optionTemplateId'] as String,
    optionTemplateValue: json['optionTemplateValue'] as String,
    optionTemplateOrder: json['optionTemplateOrder'] as int,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'response': instance.response,
      'formTemplateId': instance.formTemplateId,
      'formTemplateName': instance.formTemplateName,
      'formTemplateDescription': instance.formTemplateDescription,
      'categoryTemplateId': instance.categoryTemplateId,
      'categoryTemplateName': instance.categoryTemplateName,
      'categoryTemplateDescription': instance.categoryTemplateDescription,
      'questionTemplateId': instance.questionTemplateId,
      'questionTemplateQuestion': instance.questionTemplateQuestion,
      'questionTemplateOrder': instance.questionTemplateOrder,
      'questionTemplateDataType': instance.questionTemplateDataType,
      'optionTemplateId': instance.optionTemplateId,
      'optionTemplateValue': instance.optionTemplateValue,
      'optionTemplateOrder': instance.optionTemplateOrder,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '_id': instance.responseId,
    };
