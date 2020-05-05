// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormResponseModel _$FormResponseModelFromJson(Map<String, dynamic> json) {
  return FormResponseModel(
    formResponseId: json['_id'] as String,
    subject: json['subject'] as String,
    formTemplateId: json['formTemplateId'] as String,
    formTemplateName: json['formTemplateName'] as String,
    agent: json['agent'] as String,
    status: json['status'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$FormResponseModelToJson(FormResponseModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('formTemplateId', instance.formTemplateId);
  writeNotNull('formTemplateName', instance.formTemplateName);
  writeNotNull('agent', instance.agent);
  writeNotNull('subject', instance.subject);
  writeNotNull('status', instance.status);
  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('updatedAt', instance.updatedAt);
  writeNotNull('_id', instance.formResponseId);
  return val;
}
