import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class UserSessionRepository {
  Future<Either<Failure, void>> saveIsFirstLoad();
  Future<Either<Failure, bool>> getIsFirstLoad();
}
