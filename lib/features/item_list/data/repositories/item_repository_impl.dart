import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../data/datasources/item_remote_data_source.dart';
import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final NetworkInfo networkInfo;
  final ItemRemoteDataSource remoteDataSource;

  ItemRepositoryImpl({@required this.networkInfo, @required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Item>>> getAll() async {
    if (await networkInfo.isConnected) {
      try {
        final List<Item> items = await remoteDataSource.getAll();
        return Right(items);
      } on ServerException {
        return Left(GetAllItemsFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
