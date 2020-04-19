import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:caramelseed/core/error/failures.dart';
import 'package:caramelseed/features/authentication/data/model/user_model.dart';
import 'package:caramelseed/features/authentication/domain/entities/user.dart';
import 'package:caramelseed/features/authentication/domain/repositories/auth_repository.dart';
import 'package:caramelseed/features/authentication/domain/repositories/user_session_repository.dart';
import 'package:caramelseed/features/authentication/domain/usecases/user_session/bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserSessionRepository extends Mock implements UserSessionRepository {}

void main() {
  UserSessionBloc bloc;
  MockAuthRepository mockAuthRepository;
  MockUserSessionRepository mockUserSessionRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUserSessionRepository = MockUserSessionRepository();
    bloc = UserSessionBloc(
      authRepository: mockAuthRepository,
      userSessionRepository: mockUserSessionRepository,
    );
  });

  final UserModel userModel = UserModel.fromJson(
    jsonDecode(fixture('user.json')) as Map<String, dynamic>,
  );
  final User user = userModel;

  test('initialState should be Empty', () {
    expect(bloc.initialState, equals(Uninitialized()));
  });

  group(
    'App Started',
    () {
      test(
        'should get logged user when the app is started',
        () async {
          // arrange
          when(mockUserSessionRepository.getUserLogged()).thenAnswer((_) async => Right(user));
          // act
          bloc.add(AppStarted());
          await untilCalled(mockUserSessionRepository.getUserLogged());
          // assert
          verify(mockUserSessionRepository.getUserLogged());
        },
      );
      test(
        'should emit [Uninitialized, Authenticated] when data is gotten successfully',
        () async {
          // arrange
          when(mockUserSessionRepository.getUserLogged()).thenAnswer((_) async => Right(user));
          // assert later
          final expected = [Uninitialized(), Authenticated(user)];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(AppStarted());
        },
      );

      test(
        'should emit [Uninitialized, Unauthenticated] when data is not gotten successfully',
        () async {
          // arrange
          when(mockUserSessionRepository.getUserLogged()).thenAnswer((_) async => Left(GetCurrentSessionFailure()));
          // assert later
          final expected = [Uninitialized(), Unauthenticated()];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(AppStarted());
        },
      );
    },
  );

  group(
    'LoggedIn',
    () {
      test(
        'should get logged user when the app is started',
        () async {
          // arrange
          when(mockUserSessionRepository.getUserLogged()).thenAnswer((_) async => Right(user));
          // act
          bloc.add(LoggedIn());
          await untilCalled(mockUserSessionRepository.getUserLogged());
          // assert
          verify(mockUserSessionRepository.getUserLogged());
        },
      );
      test(
        'should emit [Uninitialized, Authenticated] when data is gotten successfully',
        () async {
          // arrange
          when(mockUserSessionRepository.getUserLogged()).thenAnswer((_) async => Right(user));
          // assert later
          final expected = [Uninitialized(), Authenticated(user)];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(LoggedIn());
        },
      );

      test(
        'should emit [Uninitialized, Unauthenticated] when data is not gotten successfully',
        () async {
          // arrange
          when(mockUserSessionRepository.getUserLogged()).thenAnswer((_) async => Left(GetCurrentSessionFailure()));
          // assert later
          final expected = [Uninitialized(), Unauthenticated()];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(LoggedIn());
        },
      );
    },
  );
}
