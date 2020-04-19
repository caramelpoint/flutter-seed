import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserSessionRepository {
  Future<void> saveUserLogged(User user);

  Future<Either<Failure, User>> getUserLogged();

  Future<void> removeUserLogged();
}
