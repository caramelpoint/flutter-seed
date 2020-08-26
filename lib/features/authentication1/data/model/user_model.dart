import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserModel extends User {
  const UserModel({
    this.userId,
    String name,
    String lastname,
    String username,
    String email,
    String createdAt,
    String updatedAt,
  }) : super(
          username: username,
          email: email,
          name: name,
          lastname: lastname,
          id: userId,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  @JsonKey(name: '_id')
  final String userId;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
