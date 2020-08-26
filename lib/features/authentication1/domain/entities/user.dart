import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id,
    this.name,
    this.lastname,
    this.username,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String lastname;
  final String username;
  final String email;
  final String createdAt;
  final String updatedAt;

  @override
  List<Object> get props => [username, email, name, lastname, createdAt, updatedAt, id];

  String getUserFullName() {
    return '$name $lastname';
  }
}
