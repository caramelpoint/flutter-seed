import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(Params params);
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
