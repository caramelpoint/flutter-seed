import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/response.dart';

part 'response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseModel extends Response {
  const ResponseModel({
    String response,
    this.responseId,
    String formTemplateId,
    String formTemplateName,
    String formTemplateDescription,
    String categoryTemplateId,
    String categoryTemplateName,
    String categoryTemplateDescription,
    String questionTemplateId,
    String questionTemplateQuestion,
    int questionTemplateOrder,
    String questionTemplateDataType,
    String optionTemplateId,
    String optionTemplateValue,
    int optionTemplateOrder,
    String createdAt,
    String updatedAt,
  }) : super(
          response: response,
          formResponseId: responseId,
          formTemplateId: formTemplateId,
          formTemplateName: formTemplateName,
          formTemplateDescription: formTemplateDescription,
          categoryTemplateId: categoryTemplateId,
          categoryTemplateName: categoryTemplateName,
          categoryTemplateDescription: categoryTemplateDescription,
          questionTemplateId: questionTemplateId,
          questionTemplateQuestion: questionTemplateQuestion,
          questionTemplateOrder: questionTemplateOrder,
          questionTemplateDataType: questionTemplateDataType,
          optionTemplateId: optionTemplateId,
          optionTemplateValue: optionTemplateValue,
          optionTemplateOrder: optionTemplateOrder,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  @JsonKey(name: '_id')
  final String responseId;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  factory ResponseModel.fromEntity(Response entity) {
    return ResponseModel(
      response: entity.response,
      // responseId: entity.formTemplateId,
      formTemplateId: entity.formTemplateId,
      formTemplateName: entity.formTemplateName,
      formTemplateDescription: entity.formTemplateDescription,
      categoryTemplateId: entity.categoryTemplateId,
      categoryTemplateName: entity.categoryTemplateName,
      categoryTemplateDescription: entity.categoryTemplateDescription,
      questionTemplateId: entity.questionTemplateId,
      questionTemplateQuestion: entity.questionTemplateQuestion,
      questionTemplateOrder: entity.questionTemplateOrder,
      questionTemplateDataType: entity.questionTemplateDataType,
      optionTemplateId: entity.optionTemplateId,
      optionTemplateValue: entity.optionTemplateValue,
      optionTemplateOrder: entity.optionTemplateOrder,
      // createdAt: entity.createdAt,
      // updatedAt: entity.updatedAt,
    );
  }
}
