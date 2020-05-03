import 'dart:convert';
import 'package:caramelseed/core/managers/token_manager.dart';
import 'package:caramelseed/core/config/env_config.dart';
import 'package:caramelseed/core/error/exceptions.dart';
import 'package:caramelseed/features/authentication/data/datasources/user_remote_data_source.dart';
import 'package:caramelseed/features/authentication/data/model/user_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockEnvConfig extends Mock implements EnvConfig {}

class MockTokenManager extends Mock implements TokenManager {}

void main() {
  UserRemoteDataSource dataSource;
  MockHttpClient mockHttpClient;
  MockTokenManager mockTokenManager;
  MockEnvConfig mockEnvConfig;

  setUp(() {
    mockTokenManager = MockTokenManager();
    mockHttpClient = MockHttpClient();
    mockEnvConfig = MockEnvConfig();
    dataSource = UserRemoteDataSourceImpl(
      client: mockHttpClient,
      tokenManager: mockTokenManager,
      envConfig: mockEnvConfig,
    );
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer(
      (_) async => http.Response(
        fixture('user.json'),
        200,
        headers: <String, String>{'authorization': 'token'},
      ),
    );
    when(mockTokenManager.saveToken(any)).thenAnswer((_) async => true);
  }

  void setUpMockHttpClient200WithOutToken() {
    when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer(
      (_) async => http.Response(
        fixture('user.json'),
        200,
      ),
    );
    when(mockTokenManager.saveToken(any)).thenThrow(SaveTokenException());
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('login', () {
    const String email = 'test@test.com';
    const String password = 'password';
    const Map<String, String> userMap = <String, String>{'email': email, 'password': password};
    final UserModel userModel = UserModel.fromJson(jsonDecode(fixture('user.json')) as Map<String, dynamic>);

    test(
      '''should perform a Post request on a URL with an email and password 
        being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.login(email: email, password: password);
        // assert
        verify(mockHttpClient.post(
          any,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(userMap),
        ));
      },
      skip: true,
    );

    test(
      'should return User when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.login(email: email, password: password);
        // assert
        expect(result, equals(userModel));
      },
      skip: true,
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.login;
        // assert
        expect(() => call(email: email, password: password), throwsA(const TypeMatcher<ServerException>()));
      },
      skip: true,
    );

    test(
      'should throw a ServerException when the token is not present on the response',
      () async {
        // arrange
        setUpMockHttpClient200WithOutToken();
        // act
        final call = dataSource.login;
        // assert
        expect(() => call(email: email, password: password), throwsA(const TypeMatcher<ServerException>()));
      },
      skip: true,
    );
  });
}
