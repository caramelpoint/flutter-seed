import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:caramelseed/core/commons/common_error_msg.dart';
import 'package:caramelseed/core/error/failures.dart';
import 'package:caramelseed/features/authentication/data/model/user_model.dart';
import 'package:caramelseed/features/authentication/domain/entities/user.dart';
import 'package:caramelseed/features/authentication/domain/repositories/auth_repository.dart';
import 'package:caramelseed/features/authentication/domain/repositories/user_session_repository.dart';
import 'package:caramelseed/features/authentication/domain/usecases/login/bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserSessionRepository extends Mock implements UserSessionRepository {}

void main() {
  LoginBloc bloc;
  MockAuthRepository mockAuthRepository;
  MockUserSessionRepository mockUserSessionRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUserSessionRepository = MockUserSessionRepository();
    bloc = LoginBloc(
      authRepository: mockAuthRepository,
      userSessionRepository: mockUserSessionRepository,
    );
  });

  test('initialState should be Empty', () {
    expect(bloc.initialState, equals(const InitialLoginState()));
  });

  group(
    'Login',
    () {
      const String email = 'test@test.com';
      const String password = 'password';
      final UserModel userModel = UserModel.fromJson(
        jsonDecode(fixture('user.json')) as Map<String, dynamic>,
      );
      final User user = userModel;

      test(
        'should login user with valid credentials',
        () async {
          // arrange
          when(mockAuthRepository.login(const Params(email: email, password: password)))
              .thenAnswer((_) async => Right(user));
          // act
          bloc.add(const LoginWithCredentials(email: email, password: password));
          await untilCalled(mockAuthRepository.login(any));
          // assert
          verify(mockAuthRepository.login(const Params(email: email, password: password)));
        },
      );
      test(
        'should emit [AuthenticatingState, AuthorizedState] when data is gotten successfully',
        () async {
          // arrange
          when(mockAuthRepository.login(const Params(email: email, password: password)))
              .thenAnswer((_) async => Right(user));
          // assert later
          final expected = [
            const InitialLoginState(),
            const AuthenticatingState(msg: CommonErrorMessage.AUTHENTICATING_MESSAGE),
            AuthorizedState(user),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const LoginWithCredentials(email: email, password: password));
        },
      );

      test(
        'should emit [AuthenticatingState, ErrorLoginState] when there is not connection',
        () async {
          // arrange
          when(mockAuthRepository.login(const Params(email: email, password: password)))
              .thenAnswer((_) async => Left(NoConnectionFailure()));
          // assert later
          final expected = [
            const InitialLoginState(),
            const AuthenticatingState(msg: CommonErrorMessage.AUTHENTICATING_MESSAGE),
            const ErrorLoginState(msg: CommonErrorMessage.NO_CONNECTION_FAILURE_MESSAGE),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const LoginWithCredentials(email: email, password: password));
        },
      );

      test(
        'should emit [AuthenticatingState, ErrorLoginState] when the credentials are wrong',
        () async {
          // arrange
          when(mockAuthRepository.login(const Params(email: email, password: password)))
              .thenAnswer((_) async => Left(LoginFailure()));
          // assert later
          final expected = [
            const InitialLoginState(),
            const AuthenticatingState(msg: CommonErrorMessage.AUTHENTICATING_MESSAGE),
            const ErrorLoginState(msg: CommonErrorMessage.LOGIN_FAILURE_MESSAGE),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const LoginWithCredentials(email: email, password: password));
        },
      );
    },
  );

  group(
    'Email Field',
    () {
      test(
        'should return LoginState (Valid) when the email is valid',
        () async {
          // assert later
          final expected = [
            const InitialLoginState(),
            const LoginState(isEmailValid: true, isPasswordValid: true),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const EmailChanged(email: 'test@test.com'));
        },
      );
      test(
        'should return LoginState (Invalid) when the email is "test"',
        () async {
          // assert later
          final expected = [
            const InitialLoginState(),
            const LoginState(isEmailValid: false, isPasswordValid: true),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const EmailChanged(email: 'test'));
        },
      );
      test(
        'should return LoginState (Invalid) when the email is "test.com"',
        () async {
          // assert later
          final expected = [
            const InitialLoginState(),
            const LoginState(isEmailValid: false, isPasswordValid: true),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const EmailChanged(email: 'test.com'));
        },
      );
      test(
        'should return LoginState (Invalid) when the email is "test@"',
        () async {
          // assert later
          final expected = [
            const InitialLoginState(),
            const LoginState(isEmailValid: false, isPasswordValid: true),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const EmailChanged(email: 'test@'));
        },
      );
    },
  );
  group(
    'Password Field',
    () {
      test(
        'should return LoginState (Valid) when the password is valid',
        () async {
          // assert later
          final expected = [
            const InitialLoginState(),
            const LoginState(isEmailValid: true, isPasswordValid: true),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const PasswordChanged(password: '123456'));
        },
      );
      test(
        'should return LoginState (Invalid) when the password is with less that six characteres',
        () async {
          // assert later
          final expected = [
            const InitialLoginState(),
            const LoginState(isEmailValid: true, isPasswordValid: false),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const PasswordChanged(password: '1234'));
        },
      );
    },
  );

  group(
    'LoginInvalidValues',
    () {
      test(
        'should return LoginInvalidValues when the password & email are invalids',
        () async {
          // assert later
          final expected = [
            const InitialLoginState(),
            const LoginInvalidValuesState(
              emailValid: false,
              passwordValid: false,
              msg: CommonErrorMessage.LOGIN_UNCOMPLETED_FIELDS,
            ),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const LoginInvalidValues(email: 'test', password: '123'));
        },
      );
      test(
        'should return LoginInvalidValues when the password is invalid',
        () async {
          // assert later
          final expected = [
            const InitialLoginState(),
            const LoginInvalidValuesState(
              emailValid: true,
              passwordValid: false,
              msg: CommonErrorMessage.LOGIN_UNCOMPLETED_FIELDS,
            ),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const LoginInvalidValues(email: 'test@gmail.com', password: '123'));
        },
      );
      test(
        'should return LoginInvalidValues when the email is invalid',
        () async {
          // assert later
          final expected = [
            const InitialLoginState(),
            const LoginInvalidValuesState(
              emailValid: false,
              passwordValid: true,
              msg: CommonErrorMessage.LOGIN_UNCOMPLETED_FIELDS,
            ),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const LoginInvalidValues(email: 'test', password: '123456'));
        },
      );
      test(
        'should return LoginInvalidValues all ok',
        () async {
          // assert later
          final expected = [
            const InitialLoginState(),
            const LoginInvalidValuesState(
              emailValid: true,
              passwordValid: true,
              msg: CommonErrorMessage.LOGIN_UNCOMPLETED_FIELDS,
            ),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(const LoginInvalidValues(email: 'test@gmail.com', password: '123456'));
        },
      );
    },
  );
}
