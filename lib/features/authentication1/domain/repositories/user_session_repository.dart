import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserSessionRepository {
  Future<Either<Failure, void>> saveUserLogged(User user);

  Future<Either<Failure, User>> getUserLogged();

  Future<Either<Failure, void>> removeUserLogged();

  Future<Either<Failure, void>> saveIsFirstLoad();

  Future<Either<Failure, bool>> getIsFirstLoad();
}
