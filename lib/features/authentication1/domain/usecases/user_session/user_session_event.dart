import 'package:equatable/equatable.dart';

abstract class UserSessionEvent extends Equatable {
  @override
  List<Object> get props => <List<Object>>[];
}

class AppStarted extends UserSessionEvent {}

class LoggedIn extends UserSessionEvent {}

class LoggedOut extends UserSessionEvent {}

class Restart extends UserSessionEvent {}

class Onboarded extends UserSessionEvent {}
