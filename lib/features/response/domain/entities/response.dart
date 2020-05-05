import 'package:equatable/equatable.dart';

class Response extends Equatable {
  const Response({
    this.response,
    this.formResponseId,
    this.formTemplateId,
    this.formTemplateName,
    this.formTemplateDescription,
    this.categoryTemplateId,
    this.categoryTemplateName,
    this.categoryTemplateDescription,
    this.questionTemplateId,
    this.questionTemplateQuestion,
    this.questionTemplateOrder,
    this.questionTemplateDataType,
    this.optionTemplateId,
    this.optionTemplateValue,
    this.optionTemplateOrder,
    this.createdAt,
    this.updatedAt,
  });

  // Response data
  final String response;
  final String formResponseId;
  // Form data
  final String formTemplateId;
  final String formTemplateName;
  final String formTemplateDescription;
  // Category data
  final String categoryTemplateId;
  final String categoryTemplateName;
  final String categoryTemplateDescription;
  // Question data
  final String questionTemplateId;
  final String questionTemplateQuestion;
  final int questionTemplateOrder;
  final String questionTemplateDataType;
  // Option data
  final String optionTemplateId;
  final String optionTemplateValue;
  final int optionTemplateOrder;

  // Meta data
  final String createdAt;
  final String updatedAt;

  @override
  List<Object> get props => [
        response,
        formResponseId,
        formTemplateId,
        formTemplateName,
        formTemplateDescription,
        categoryTemplateId,
        categoryTemplateName,
        categoryTemplateDescription,
        questionTemplateId,
        questionTemplateQuestion,
        questionTemplateOrder,
        questionTemplateDataType,
        optionTemplateId,
        optionTemplateValue,
        optionTemplateOrder,
        createdAt,
        updatedAt,
      ];
}
