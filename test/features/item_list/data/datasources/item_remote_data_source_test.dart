import 'dart:convert';
import 'dart:io';
import 'package:caramelseed/core/authorization/token_manager.dart';
import 'package:caramelseed/core/commons/common_response.dart';
import 'package:caramelseed/core/config/env_config.dart';
import 'package:caramelseed/core/error/exceptions.dart';
import 'package:caramelseed/features/item_list/data/datasources/item_remote_data_source.dart';
import 'package:caramelseed/features/item_list/data/model/item_model.dart';
import 'package:caramelseed/features/item_list/domain/entities/item.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockEnvConfig extends Mock implements EnvConfig {}

class MockTokenManager extends Mock implements TokenManager {}

void main() {
  ItemRemoteDataSource dataSource;
  MockHttpClient mockHttpClient;
  MockTokenManager mockTokenManager;
  MockEnvConfig mockEnvConfig;

  setUp(() {
    mockTokenManager = MockTokenManager();
    mockHttpClient = MockHttpClient();
    mockEnvConfig = MockEnvConfig();
    dataSource = ItemRemoteDataSourceImpl(
      client: mockHttpClient,
      tokenManager: mockTokenManager,
      envConfig: mockEnvConfig,
    );
  });

  void setToken() {
    when(mockTokenManager.getToken()).thenReturn('Token');
  }

  void setEnvConfig() {
    when(mockEnvConfig.apiUrl()).thenReturn('http://localhost:3000/');
  }

  void setUpMockHttpClientSuccess200() {
    setEnvConfig();
    setToken();
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('get_all_items.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    setEnvConfig();
    setToken();
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpClientException() {
    setEnvConfig();
    setToken();
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenThrow(const HttpException('Http Request Failed'));
  }

  group('Get All', () {
    final CommonResponse<ItemModel> commonResponse = CommonResponse<ItemModel>.fromJson(
        jsonDecode(fixture('get_all_items.json')) as Map<String, dynamic>);
    final List<Item> itemList = commonResponse.data;
    test(
      'should return an Item List when the response code is 200 (success).',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getAll();
        // assert
        expect(result, equals(itemList));
      }, skip: true
    );

    test(
      'should throw a ServerException when the response code is 404 or other.',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getAll;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      }, skip: true
    );

    test(
      'should throw a ServerException when the token is not present on the storage.',
      () async {
        // arrange
        when(mockTokenManager.saveToken(any)).thenThrow(GetTokenException());
        // act
        final call = dataSource.getAll;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      }, skip: true
    );

    test(
      'should throw a ServerException when the request throw and exception.',
      () async {
        // arrange
        setUpMockHttpClientException();
        // act
        final call = dataSource.getAll;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      }, skip: true
    );
  });
}
