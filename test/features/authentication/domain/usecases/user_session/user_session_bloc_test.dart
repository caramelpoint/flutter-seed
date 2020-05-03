import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:caramelseed/core/commons/common_messages.dart';
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
  MockUserSessionRepository mockUserSessionRepository;

  setUp(() {
    mockUserSessionRepository = MockUserSessionRepository();
    bloc = UserSessionBloc(
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
      blocTest(
        'should get logged user when the app is started',
        build: () async {
          when(mockUserSessionRepository.getUserLogged()).thenAnswer((_) async => Right(user));
          return UserSessionBloc(userSessionRepository: mockUserSessionRepository);
        },
        act: (bloc) => bloc.add(AppStarted()) as Future<void>,
        skip: 0,
        verify: (_) async {
          verify(mockUserSessionRepository.getUserLogged());
        },
      );

      blocTest(
        'should emit [Uninitialized, Authenticated] when data is gotten successfully',
        build: () async {
          when(mockUserSessionRepository.getUserLogged()).thenAnswer((_) async => Right(user));
          return UserSessionBloc(userSessionRepository: mockUserSessionRepository);
        },
        act: (bloc) => bloc.add(AppStarted()) as Future<void>,
        skip: 0,
        expect: [Uninitialized(), Authenticated(user)],
      );
      blocTest(
        'should emit [Uninitialized, Unauthenticated] when data is not gotten successfully',
        build: () async {
          when(mockUserSessionRepository.getUserLogged()).thenAnswer((_) async => Left(GetCurrentSessionFailure()));
          return UserSessionBloc(userSessionRepository: mockUserSessionRepository);
        },
        act: (bloc) => bloc.add(AppStarted()) as Future<void>,
        skip: 0,
        expect: [Uninitialized(), Unauthenticated()],
      );
    },
  );

  group(
    'LoggedIn',
    () {
      blocTest('should get logged user when the app is started',
          build: () async {
            when(mockUserSessionRepository.getUserLogged()).thenAnswer((_) async => Right(user));
            return UserSessionBloc(userSessionRepository: mockUserSessionRepository);
          },
          act: (bloc) => bloc.add(LoggedIn()) as Future<void>,
          skip: 0,
          verify: (_) async {
            verify(mockUserSessionRepository.getUserLogged());
          });

      blocTest(
        'should emit [Uninitialized, Authenticated] when data is gotten successfully',
        build: () async {
          when(mockUserSessionRepository.getUserLogged()).thenAnswer((_) async => Right(user));
          return UserSessionBloc(userSessionRepository: mockUserSessionRepository);
        },
        act: (bloc) => bloc.add(LoggedIn()) as Future<void>,
        skip: 0,
        expect: [Uninitialized(), Authenticated(user)],
      );

      blocTest(
        'should emit [Uninitialized, Unauthenticated] when data is not gotten successfully',
        build: () async {
          when(mockUserSessionRepository.getUserLogged()).thenAnswer((_) async => Left(GetCurrentSessionFailure()));
          return UserSessionBloc(userSessionRepository: mockUserSessionRepository);
        },
        act: (bloc) => bloc.add(LoggedIn()) as Future<void>,
        skip: 0,
        expect: [Uninitialized(), Unauthenticated()],
      );
    },
  );

  group(
    'LoggedOut',
    () {
      test(
        'should remove user Logged correctly from shared preferences (old)',
        () async {
          // arrange
          when(mockUserSessionRepository.removeUserLogged()).thenAnswer((_) async => const Right(null));
          // act
          bloc.add(LoggedOut());
          await untilCalled(mockUserSessionRepository.removeUserLogged());
          // assert
          verify(mockUserSessionRepository.removeUserLogged());
        },
      );

      blocTest('should remove user Logged correctly from shared preferences',
          build: () async {
            when(mockUserSessionRepository.removeUserLogged()).thenAnswer((_) async => const Right(null));
            return UserSessionBloc(userSessionRepository: mockUserSessionRepository);
          },
          act: (bloc) => bloc.add(LoggedOut()) as Future<void>,
          skip: 0,
          verify: (_) async {
            verify(mockUserSessionRepository.removeUserLogged());
          });

      blocTest(
        'should emit [Uninitialized, Unauthenticated] when LoggedOut event triggered',
        build: () async {
          when(mockUserSessionRepository.removeUserLogged()).thenAnswer((_) async => const Right(null));
          return UserSessionBloc(userSessionRepository: mockUserSessionRepository);
        },
        act: (bloc) => bloc.add(LoggedOut()) as Future<void>,
        skip: 0,
        expect: [
          Uninitialized(),
          Unauthenticated(),
        ],
      );
      blocTest(
        'should emit [Uninitialized, LogoutError] when LoggedOut event triggered',
        build: () async {
          when(mockUserSessionRepository.removeUserLogged()).thenAnswer((_) async => Left(CouldNotRemoveUserFailure()));
          return UserSessionBloc(userSessionRepository: mockUserSessionRepository);
        },
        act: (bloc) => bloc.add(LoggedOut()) as Future<void>,
        skip: 0,
        expect: [
          Uninitialized(),
          const ErrorSessionState(msg: CommonMessage.CLEARING_USER_SESSION_ERROR),
        ],
      );
    },
  );
}
