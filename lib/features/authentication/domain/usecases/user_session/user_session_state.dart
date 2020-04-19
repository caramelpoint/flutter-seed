import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

abstract class UserSessionState extends Equatable {
  const UserSessionState();

  @override
  List<Object> get props => <List<Object>>[];
}

class Authenticated extends UserSessionState {
  const Authenticated(this.user);

  final User user;

  @override
  List<Object> get props => <User>[user];

  @override
  String toString() {
    return 'Authenticated { username: ${user.username}, email: ${user.email} }';
  }
}

class Uninitialized extends UserSessionState {}

class Unauthenticated extends UserSessionState {}
