import 'package:equatable/equatable.dart';

import 'question_template.dart';

class CategoryTemplate extends Equatable {
  final String id;
  final String name;
  final int order;
  final String description;
  final List<QuestionTemplate> questionTemplates;
  final String createdAt;
  final String updatedAt;

  const CategoryTemplate({
    this.id,
    this.name,
    this.description,
    this.order,
    this.questionTemplates,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object> get props => [id, name, description, order, questionTemplates, createdAt, updatedAt];
}

// import 'package:gowelii/domain/models/question_template.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'category_template.g.dart';

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
// class CategoryTemplate {
//   CategoryTemplate({
//     this.id,
//     this.name,
//     this.description,
//     this.order,
//     this.questionTemplates,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory CategoryTemplate.fromJson(Map<String, dynamic> json) => _$CategoryTemplateFromJson(json);

//   Map<String, dynamic> toJson() => _$CategoryTemplateToJson(this);

//   @JsonKey(name: '_id')
//   final String id;
//   final String name;
//   final int order;
//   final String description;
//   final List<QuestionTemplate> questionTemplates;
//   final String createdAt;
//   final String updatedAt;
// }
