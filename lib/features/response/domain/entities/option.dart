import 'package:equatable/equatable.dart';

class Option extends Equatable {
  final String id;
  final String value;
  final String createdAt;
  final String updatedAt;

  const Option({
    this.id,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object> get props => [id, value, createdAt, updatedAt];
}

// import 'package:json_annotation/json_annotation.dart';

// part 'option.g.dart';

// @JsonSerializable(explicitToJson: true, includeIfNull: false)
// class Option {
//   Option({
//     this.id,
//     this.value,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

//   Map<String, dynamic> toJson() => _$OptionToJson(this);

//   @JsonKey(name: '_id')
//   final String id;
//   final String value;
//   final String createdAt;
//   final String updatedAt;
// }
