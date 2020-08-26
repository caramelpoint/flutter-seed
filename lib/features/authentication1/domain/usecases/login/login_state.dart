import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/commons/common_state.dart';
import '../../entities/user.dart';

class LoginState extends Equatable implements CommonState {
  const LoginState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
  });

  final bool isEmailValid;
  final bool isPasswordValid;

  LoginState update({bool isEmailValid, bool isPasswordValid}) {
    return _copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
    );
  }

  LoginState _copyWith({bool isEmailValid, bool isPasswordValid}) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }

  @override
  List<Object> get props => <Object>[isEmailValid, isPasswordValid];

  @override
  String toString() => 'LoginState { isEmailValid: $isEmailValid, isPasswordValid: $isPasswordValid }';
}

class InitialLoginState extends LoginState {
  const InitialLoginState() : super(isEmailValid: true, isPasswordValid: true);
  @override
  String toString() => 'InitialLoginState { isEmailValid: $isEmailValid, isPasswordValid: $isPasswordValid }';
}

class TransitionState extends LoginState implements LoadingState {
  final String msg;

  const TransitionState({@required this.msg});

  @override
  String get message => msg;

  @override
  String toString() => 'TransitionState { msg: $msg }';
}

class AuthenticatingState extends LoginState implements LoadingState {
  const AuthenticatingState({@required this.msg}) : super(isEmailValid: true, isPasswordValid: true);

  final String msg;

  @override
  List<Object> get props => [message];

  @override
  String get message => msg;

  @override
  String toString() => 'AuthenticatingState { isEmailValid: $isEmailValid, isPasswordValid: $isPasswordValid }';
}

class AuthorizedState extends LoginState {
  final User user;

  const AuthorizedState(this.user) : super(isEmailValid: true, isPasswordValid: true);

  @override
  List<Object> get props => <Object>[user];

  @override
  String toString() => 'AuthorizedState { email: ${user.email} }';
}

class LoginInvalidValuesState extends LoginState implements ErrorState {
  final String msg;
  const LoginInvalidValuesState({bool emailValid, bool passwordValid, @required this.msg})
      : super(isEmailValid: emailValid, isPasswordValid: passwordValid);

  @override
  List<Object> get props => [message];

  @override
  String get message => msg;

  @override
  String toString() => 'LoginInvalidValuesState { isEmailValid: $isEmailValid, isPasswordValid: $isPasswordValid }';
}

class ErrorLoginState extends LoginState implements ErrorState {
  final String msg;

  const ErrorLoginState({this.msg}) : super(isEmailValid: true, isPasswordValid: true);

  @override
  List<Object> get props => [message];

  @override
  String get message => msg;

  @override
  String toString() => 'ErrorLoginState { message: $message }';
}
