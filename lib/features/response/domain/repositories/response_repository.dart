import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/response.dart';

abstract class ResponseRepository {
  Future<Either<Failure, Response>> saveResponse(Response response);
}
