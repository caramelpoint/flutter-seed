import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/commons/common_messages.dart';
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
    } else if (event is Restart) {
      yield Uninitialized();
    } else if (event is Onboarded) {
      yield* _mapOnBoardedToState();
    }
  }

  Stream<UserSessionState> _mapOnBoardedToState() async* {
    final Either<Failure, void> failureOrSuccess = await userSessionRepository.saveIsFirstLoad();
    yield failureOrSuccess.fold(
      (failure) => const ErrorSessionState(msg: CommonMessage.SAVING_IS_FIRST_LOAD_ERROR),
      (_) => const Unauthenticated(isFirstLoad: false),
    );
  }

  Stream<UserSessionState> _mapAppStartedToState() async* {
    final bool isFirstLoad = await _getIsFirstLoad();
    final Either<Failure, User> failureOrUser = await userSessionRepository.getUserLogged();
    yield failureOrUser.fold(
      (failure) => isFirstLoad ? const Unauthenticated(isFirstLoad: true) : const Unauthenticated(isFirstLoad: false),
      (user) => Authenticated(user),
    );
  }

  Stream<UserSessionState> _mapLoggedInToState() async* {
    yield* _getUser();
  }

  Future<bool> _getIsFirstLoad() async {
    final Either<Failure, bool> failureOrIsFirstLoad = await userSessionRepository.getIsFirstLoad();
    if (failureOrIsFirstLoad.isRight()) {
      return failureOrIsFirstLoad.getOrElse(null);
    }
    return true;
  }

  Stream<UserSessionState> _getUser() async* {
    final Either<Failure, User> failureOrUser = await userSessionRepository.getUserLogged();
    yield failureOrUser.fold(
      (failure) => const Unauthenticated(),
      (user) => Authenticated(user),
    );
  }

  Stream<UserSessionState> _mapLoggedOutToState() async* {
    final Either<Failure, void> failureOrSuccess = await userSessionRepository.removeUserLogged();
    yield failureOrSuccess.fold(
      (failure) => const ErrorSessionState(msg: CommonMessage.CLEARING_USER_SESSION_ERROR),
      (_) => const Unauthenticated(),
    );
  }
}
