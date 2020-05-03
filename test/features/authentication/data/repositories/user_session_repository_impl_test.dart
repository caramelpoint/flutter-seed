import 'dart:convert';

import 'package:caramelseed/core/error/failures.dart';
import 'package:caramelseed/features/authentication/data/model/user_model.dart';
import 'package:caramelseed/features/authentication/data/repositories/user_session_repository_impl.dart';
import 'package:caramelseed/features/authentication/domain/repositories/user_session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  UserSessionRepository userSessionRepository;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    userSessionRepository = UserSessionRepositoryImpl(sharedPreferences: mockSharedPreferences);
  });

  final UserModel userModel = UserModel.fromJson(
    jsonDecode(fixture('user.json')) as Map<String, dynamic>,
  );

  group(
    'Get User Logged',
    () {
      test(
        'should return a user when there is a user in the share preferences',
        () async {
          when(mockSharedPreferences.getString(any)).thenReturn(fixture('user.json'));

          final result = await userSessionRepository.getUserLogged();

          verify(mockSharedPreferences.getString(LOGGED_USER));
          expect(result, Right(userModel));
        },
      );
      test(
        'should return a failure when there is a not a user in the share preferences',
        () async {
          when(mockSharedPreferences.getString(any)).thenReturn(null);

          final result = await userSessionRepository.getUserLogged();

          verify(mockSharedPreferences.getString(LOGGED_USER));
          expect(result, Left(GetCurrentSessionFailure()));
        },
      );
    },
  );

  group(
    'Remove User Logged',
    () {
      test(
        'should remove the user logged when there is a user in the share preferences',
        () async {
          // arrange
          when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);
          // act
          await userSessionRepository.removeUserLogged();
          // assert
          verify(mockSharedPreferences.remove(LOGGED_USER));
        },
      );

      test(
        'should return void when the user is correctly remove from share preferences',
        () async {
          // arrange
          when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);
          // act
          final result = await userSessionRepository.removeUserLogged();
          // assert
          expect(result, Right(null));
        },
      );

      test(
        'should return Failure when user could not be removed from share preferences',
        () async {
          // arrange
          when(mockSharedPreferences.remove(any)).thenAnswer((_) async => false);
          // act
          final result = await userSessionRepository.removeUserLogged();
          // assert
          expect(result, Left(CouldNotRemoveUserFailure()));
        },
      );
    },
  );

  group(
    'Save User Logged',
    () {
      test(
        'should save the logged user in the share preferences',
        () async {
          // arrange
          when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);
          // act
          userSessionRepository.saveUserLogged(userModel);
          // assert
          final expectedJsonString = json.encode(userModel.toJson());
          verify(mockSharedPreferences.setString(LOGGED_USER, expectedJsonString));
        },
      );

      test(
        'should return void when user is saved in the share preferences',
        () async {
          // arrange
          when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);
          // act
          final result = await userSessionRepository.saveUserLogged(userModel);
          // assert
          expect(result, Right(null));
        },
      );

      test(
        'should return Failure when user could not be saved in the share preferences ',
        () async {
          // arrange
          when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => false);
          // act
          final result = await userSessionRepository.saveUserLogged(userModel);
          // assert
          expect(result, Left(CouldNotSaveUserFailure()));
        },
      );
    },
  );
}
