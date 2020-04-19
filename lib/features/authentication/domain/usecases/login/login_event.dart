import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => <List<Object>>[];
}

class EmailChanged extends LoginEvent {
  const EmailChanged({@required this.email});

  final String email;

  @override
  List<Object> get props => <String>[email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends LoginEvent {
  const PasswordChanged({@required this.password});

  final String password;

  @override
  List<Object> get props => <String>[password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class LoginWithCredentials extends LoginEvent {
  const LoginWithCredentials({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => <String>[email, password];

  @override
  String toString() {
    return 'LoginWithCredentials { email: $email, password: $password }';
  }
}

class LoginInvalidValues extends LoginEvent {
  const LoginInvalidValues({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => <String>[email, password];

  @override
  String toString() {
    return 'LoginInvalidValues { email: $email, password: $password }';
  }
}
