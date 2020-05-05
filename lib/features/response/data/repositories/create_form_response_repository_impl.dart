import 'package:caramelseed/features/response/domain/entities/form_response.dart';
import 'package:caramelseed/features/response/domain/entities/form_template.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/create_form_response_repository.dart';
import '../datasource/create_form_response_remote_data_source.dart';

class CreateFormResponseRepositoryImpl extends CreateFormResponseRepository {
  final NetworkInfo networkInfo;
  final CreateFormResponseRemoteDataSource remoteDataSource;

  CreateFormResponseRepositoryImpl({@required this.networkInfo, @required this.remoteDataSource});

  @override
  Future<Either<Failure, FormResponse>> createFormResponse(FormTemplate formTemplate) async {
    if (await networkInfo.isConnected) {
      try {
        final FormResponse formResponse = await remoteDataSource.create(formTemplate);
        return Right(formResponse);
      } on ServerException {
        return Left(CreateFormResponseFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
