import 'package:equatable/equatable.dart';

import 'category_template.dart';

class FormTemplate extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<CategoryTemplate> categoryTemplates;
  final String createdAt;
  final String updatedAt;

  const FormTemplate({
    this.id,
    this.name,
    this.description,
    this.categoryTemplates,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object> get props => [id, name, description, categoryTemplates, createdAt, updatedAt];
}

// import 'package:gowelii/domain/models/category_template.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'form_template.g.dart';

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
// class FormTemplate {
//   FormTemplate({
//     this.id,
//     this.name,
//     this.description,
//     this.categoryTemplates,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory FormTemplate.fromJson(Map<String, dynamic> json) => _$FormTemplateFromJson(json);

//   Map<String, dynamic> toJson() => _$FormTemplateToJson(this);

//   @JsonKey(name: '_id')
//   final String id;
//   final String name;
//   final String description;
//   final List<CategoryTemplate> categoryTemplates;
//   final String createdAt;
//   final String updatedAt;
// }
