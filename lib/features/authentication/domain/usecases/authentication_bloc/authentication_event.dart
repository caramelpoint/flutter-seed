import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => <List<Object>>[];
}

class AppStarted extends AuthenticationEvent {}

class SignIn extends AuthenticationEvent {}

class SignOut extends AuthenticationEvent {}

class Onboarded extends AuthenticationEvent {}
