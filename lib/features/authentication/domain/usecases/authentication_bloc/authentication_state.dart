import 'package:caramelseed/core/commons/common_state.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => <List<Object>>[];
}

class Uninitialized extends AuthenticationState{
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  const Authenticated(this.user);

  final FirebaseUser user;

  @override
  List<Object> get props => <String>[user.uid];

  @override
  String toString() {
    return 'Authenticated { username: ${user.displayName}, email: ${user.email} }';
  }
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated({this.isFirstLoad = false});

  final bool isFirstLoad;

  @override
  List<Object> get props => <bool>[isFirstLoad];

  @override
  String toString() {
    return 'Authenticated { isFirstLoad: $isFirstLoad }';
  }
}

class ErrorAuthenticationState extends AuthenticationState implements ErrorState {
  final String msg;

  const ErrorAuthenticationState({this.msg});

  @override
  String toString() => 'ErrorAuthenticationState { message: $message }';

  @override
  List<Object> get props => [message];

  @override
  String get message => msg;
}
