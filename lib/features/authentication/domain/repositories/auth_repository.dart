import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> signOut();
  Future<Either<Failure, FirebaseUser>> signInWithCredentials(Params params);
  Future<Either<Failure, FirebaseUser>> signInWithGoogle();
  Future<Either<Failure, FirebaseUser>> signInWithFacebook();
  Future<Either<Failure, FirebaseUser>> signup(Params params);
  Future<Either<Failure, bool>> isSignedIn();
  Future<Either<Failure, FirebaseUser>> getuser();
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
