import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/user_session_repository.dart';

const IS_FIRST_LOAD = 'IS_FIRST_LOAD';

class UserSessionRepositoryImpl implements UserSessionRepository {
  final SharedPreferences sharedPreferences;

  UserSessionRepositoryImpl({@required this.sharedPreferences});

  @override
  Future<Either<Failure, bool>> getIsFirstLoad() async {
    final bool isFirstLoad = sharedPreferences.getBool(IS_FIRST_LOAD);
    if (isFirstLoad == null) {
      return Left(GetIsFirstLoadFailure());
    }
    return Right(isFirstLoad);
  }

  @override
  Future<Either<Failure, void>> saveIsFirstLoad() async {
    final bool isFirstLoad = await sharedPreferences.setBool(IS_FIRST_LOAD, false);
    if (isFirstLoad) {
      return const Right(null);
    } else {
      return Left(CouldNotSaveIsLoadTimeFailure());
    }
  }
}
