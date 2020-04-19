import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:caramelseed/core/error/failures.dart';
import 'package:caramelseed/features/authentication/data/model/user_model.dart';
import 'package:caramelseed/features/authentication/data/repositories/user_session_repository_impl.dart';
import 'package:caramelseed/features/authentication/domain/repositories/user_session_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  UserSessionRepository dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = UserSessionRepositoryImpl(sharedPreferences: mockSharedPreferences);
  });

  group(
    'Get User Logged',
    () {
      final UserModel userModel = UserModel.fromJson(
        jsonDecode(fixture('user.json')) as Map<String, dynamic>,
      );
      test(
        'should return a user when there is a user in the share preferences',
        () async {
          when(mockSharedPreferences.getString(any)).thenReturn(fixture('user.json'));

          final result = await dataSource.getUserLogged();

          verify(mockSharedPreferences.getString(any));
          expect(result, Right(userModel));
        },
      );
      test(
        'should return a failure when there is a not a user in the share preferences',
        () async {
          when(mockSharedPreferences.getString(any)).thenAnswer((_) => null);

          final result = await dataSource.getUserLogged();

          verify(mockSharedPreferences.getString(any));
          expect(result, Left(GetCurrentSessionFailure()));
        },
      );
    },
  );
}

// final String userString = sharedPreferences.getString(LOGGED_USER);
//     if (userString == null) {
//       return Left(GetCurrentSessionFailure());
//     }
//     final UserModel userModel = UserModel.fromJson(jsonDecode(userString) as Map<String, dynamic>);
//     return Right(userModel);
