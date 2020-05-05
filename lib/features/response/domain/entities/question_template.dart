import 'package:equatable/equatable.dart';

import 'option.dart';

class QuestionTemplate extends Equatable {
  final String id;
  final int order;
  final String question;
  final String dataType;
  final List<Option> options;
  final List<QuestionTemplate> subQuestionTemplates;
  final String createdAt;
  final String updatedAt;

  const QuestionTemplate({
    this.id,
    this.order,
    this.question,
    this.dataType,
    this.options,
    this.subQuestionTemplates,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object> get props => [
        id,
        order,
        question,
        dataType,
        options,
        subQuestionTemplates,
        createdAt,
        updatedAt,
      ];
}

// import 'package:gowelii/domain/models/option.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'question_template.g.dart';

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
// class QuestionTemplate {
//   QuestionTemplate({
//     this.id,
//     this.order,
//     this.question,
//     this.dataType,
//     this.options,
//     this.subQuestionTemplates,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory QuestionTemplate.fromJson(Map<String, dynamic> json) => _$QuestionTemplateFromJson(json);

//   Map<String, dynamic> toJson() => _$QuestionTemplateToJson(this);

//   @JsonKey(name: '_id')
//   final String id;
//   final int order;
//   final String question;
//   final String dataType;
//   final List<Option> options;
//   final List<QuestionTemplate> subQuestionTemplates;
//   final String createdAt;
//   final String updatedAt;
// }
