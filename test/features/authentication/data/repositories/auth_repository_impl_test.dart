import 'package:caramelseed/core/error/exceptions.dart';
import 'package:caramelseed/core/error/failures.dart';
import 'package:caramelseed/core/network/network_info.dart';
import 'package:caramelseed/features/authentication/data/datasources/user_remote_data_source.dart';
import 'package:caramelseed/features/authentication/data/model/user_model.dart';
import 'package:caramelseed/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:caramelseed/features/authentication/domain/entities/user.dart';
import 'package:caramelseed/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

void main() {
  AuthRepositoryImpl repository;
  MockNetworkInfo mockNetworkInfo;
  MockUserRemoteDataSource mockUserRemoteDataSource;
  String email;
  String password;
  const UserModel userModel = UserModel(
    name: 'Test name',
    userId: 'Test id',
    email: 'test@test.com',
    username: 'Test username',
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
  );
  User user = userModel;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    repository = AuthRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockUserRemoteDataSource,
    );
    email = 'test@test.com';
    password = 'Test pass';
    user = userModel;
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('login', () {
    runTestsOffline(() {
      test(
        'should return a no connection failure',
        () async {
          when(mockUserRemoteDataSource.login(email: email, password: password)).thenAnswer((_) async => userModel);

          final result = await repository.login(Params(email: email, password: password));

          verifyNever(mockUserRemoteDataSource.login(email: email, password: password));
          expect(result, Left(NoConnectionFailure()));
        },
      );
    });

    runTestsOnline(() {
      const String wrongEmail = 'wrong@cred.com';
      const String wrongPwd = 'wrongPwd';
      test(
        'should return a login failure when the credentials are wrong',
        () async {
          when(mockUserRemoteDataSource.login(email: wrongEmail, password: wrongPwd))
              .thenThrow(WrongCredentialsException());

          final result = await repository.login(const Params(email: wrongEmail, password: wrongPwd));

          verify(mockUserRemoteDataSource.login(email: wrongEmail, password: wrongPwd));
          expect(result, Left(LoginFailure()));
        },
      );

      test(
        'should return a login failure when a server error occurs',
        () async {
          when(mockUserRemoteDataSource.login(email: email, password: password)).thenThrow(ServerException());

          final result = await repository.login(Params(email: email, password: password));

          verify(mockUserRemoteDataSource.login(email: email, password: password));
          expect(result, Left(LoginFailure()));
        },
      );

      test(
        'should return a user instance when the login is successfull',
        () async {
          when(mockUserRemoteDataSource.login(email: email, password: password)).thenAnswer((_) async => userModel);

          final result = await repository.login(Params(email: email, password: password));

          verify(mockUserRemoteDataSource.login(email: email, password: password));
          expect(result, Right(user));
        },
      );
    });
  });
}
