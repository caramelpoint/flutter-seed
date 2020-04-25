import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/commons/common_error_msg.dart';
import '../../../../../core/error/failures.dart';
import '../../entities/user.dart';
import '../../repositories/user_session_repository.dart';
import 'bloc.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  final UserSessionRepository userSessionRepository;

  UserSessionBloc({
    @required this.userSessionRepository,
  });

  @override
  UserSessionState get initialState => Uninitialized();

  @override
  Stream<UserSessionState> mapEventToState(UserSessionEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<UserSessionState> _mapAppStartedToState() async* {
    try {
      yield* _getUser();
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<UserSessionState> _mapLoggedInToState() async* {
    yield* _getUser();
  }

  Stream<UserSessionState> _getUser() async* {
    final Either<Failure, User> failureOrUser = await userSessionRepository.getUserLogged();
    yield failureOrUser.fold(
      (failure) => Unauthenticated(),
      (user) => Authenticated(user),
    );
  }

  Stream<UserSessionState> _mapLoggedOutToState() async* {
    final Either<Failure, void> failureOrSuccess = await userSessionRepository.removeUserLogged();
    yield failureOrSuccess.fold(
      (failure) => const ErrorSessionState(msg: CommonErrorMessage.CLEARING_USER_SESSION_ERROR),
      (_) => Unauthenticated(),
    );
  }
}
