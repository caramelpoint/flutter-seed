import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/form_response.dart';

part 'form_response_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FormResponseModel extends FormResponse {
  const FormResponseModel({
    this.formResponseId,
    String subject,
    String formTemplateId,
    String formTemplateName,
    String agent,
    String status,
    String createdAt,
    String updatedAt,
  }) : super(
          id: formResponseId,
          subject: subject,
          formTemplateId: formTemplateId,
          formTemplateName: formTemplateName,
          agent: agent,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  @JsonKey(name: '_id')
  final String formResponseId;

  factory FormResponseModel.fromJson(Map<String, dynamic> json) => _$FormResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormResponseModelToJson(this);
}
