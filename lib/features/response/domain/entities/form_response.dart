import 'package:equatable/equatable.dart';

class FormResponse extends Equatable {
  final String id;
  final String formTemplateId;
  final String formTemplateName;
  final String agent;
  final String subject;
  final String status;
  final String createdAt;
  final String updatedAt;

  const FormResponse({
    this.id,
    this.formTemplateId,
    this.formTemplateName,
    this.agent,
    this.subject,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object> get props => [id, formTemplateId, formTemplateName, agent, subject, status, createdAt, updatedAt];
}
