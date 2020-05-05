import 'package:caramelseed/features/response/domain/entities/form_response.dart';
import 'package:caramelseed/features/response/domain/entities/form_template.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class CreateFormResponseRepository {
  Future<Either<Failure, FormResponse>> createFormResponse(FormTemplate formTemplate);
}
