import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/user_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    @required this.networkInfo,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, User>> login(Params params) async {
    if (await networkInfo.isConnected) {
      try {
        final User user = await remoteDataSource.login(email: params.email, password: params.password);
        return Right(user);
      } on ServerException {
        return Left(LoginFailure());
      } on WrongCredentialsException {
        return Left(LoginFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
