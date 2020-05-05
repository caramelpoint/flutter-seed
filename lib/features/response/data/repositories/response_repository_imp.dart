import 'package:caramelseed/core/error/exceptions.dart';
import 'package:caramelseed/core/error/failures.dart';
import 'package:caramelseed/core/network/network_info.dart';
import 'package:caramelseed/features/response/data/datasource/response_remote_data_source.dart';
import 'package:caramelseed/features/response/domain/entities/response.dart';
import 'package:caramelseed/features/response/domain/repositories/response_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class ResponseRepositoryImp extends ResponseRepository {
  final NetworkInfo networkInfo;
  final ResponseRemoteDataSource remoteDataSource;

  ResponseRepositoryImp({@required this.networkInfo, @required this.remoteDataSource});

  @override
  Future<Either<Failure, Response>> saveResponse(Response response) async {
    if (await networkInfo.isConnected) {
      try {
        final Response saveResponse = await remoteDataSource.saveResponse(response);
        return Right(saveResponse);
      } on ServerException {
        return Left(SaveResponseFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
