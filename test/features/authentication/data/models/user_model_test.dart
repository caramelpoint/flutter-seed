import 'dart:convert';

import 'package:caramelseed/features/authentication/data/model/user_model.dart';
import 'package:caramelseed/features/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel(
    userId: 'Test id',
    name: 'Test name',
    lastname: 'Test lastname',
    email: 'test@test.com',
    username: 'Test username',
    createdAt: "Test createdAt",
    updatedAt: "Test updateAt",
  );

  test(
    'should be a subclass of User entity',
    () async {
      // assert
      expect(tUserModel, isA<User>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model using a User Json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('user.json')) as Map<String, dynamic>;
        // act
        final result = UserModel.fromJson(jsonMap);
        // assert
        expect(result, tUserModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tUserModel.toJson();
        // assert
        final expectedMap = {
          "name": "Test name",
          "username": "Test username",
          "lastname": "Test lastname",
          "_id": "Test id",
          "email": "test@test.com",
          "createdAt": "Test createdAt",
          "updatedAt": "Test updateAt"
        };
        expect(result, expectedMap);
      },
    );
  });
}
