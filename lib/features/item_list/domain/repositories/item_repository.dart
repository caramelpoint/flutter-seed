import 'package:dartz/dartz.dart';
import 'package:caramelseed/core/error/failures.dart';
import '../entities/item.dart';

abstract class ItemRepository {
  Future<Either<Failure, List<Item>>> getAll();
}
