import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_session_repository.dart';
import '../model/user_model.dart';

const LOGGED_USER = 'LOGGED_USER';
const IS_LOGGED_IN = 'IS_LOGGED_IN';

class UserSessionRepositoryImpl implements UserSessionRepository {
  final SharedPreferences sharedPreferences;

  UserSessionRepositoryImpl({@required this.sharedPreferences});

  @override
  Future<Either<Failure, User>> getUserLogged() async {
    final String userString = sharedPreferences.getString(LOGGED_USER);
    if (userString == null) {
      return Left(GetCurrentSessionFailure());
    }
    final UserModel userModel = UserModel.fromJson(jsonDecode(userString) as Map<String, dynamic>);
    return Right(userModel);
  }

  @override
  Future<Either<Failure, void>> removeUserLogged() async {
    final bool isUserRemoved = await sharedPreferences.remove(LOGGED_USER);
    if (isUserRemoved) {
      return Right(null);
    } else {
      return Left(CouldNotRemoveUserFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveUserLogged(User user) async {
    final UserModel userModel = UserModel(
      email: user.email,
      username: user.username,
      name: user.name,
      lastname: user.lastname,
      userId: user.id,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
    final bool isUserSaved = await sharedPreferences.setString(LOGGED_USER, jsonEncode(userModel.toJson()));
    if (isUserSaved) {
      return Right(null);
    } else {
      return Left(CouldNotSaveUserFailure());
    }
  }
}
