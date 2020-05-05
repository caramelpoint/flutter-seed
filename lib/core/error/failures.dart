import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginFailure extends Failure {}

class GetCurrentSessionFailure extends Failure {}

class CouldNotRemoveUserFailure extends Failure {}

class CouldNotSaveUserFailure extends Failure {}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NoConnectionFailure extends Failure {}

class GetAllItemsFailure extends Failure {}

class SaveResponseFailure extends Failure {}

class CreateFormResponseFailure extends Failure {}
