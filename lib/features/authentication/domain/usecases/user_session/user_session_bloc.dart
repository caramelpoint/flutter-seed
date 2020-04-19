import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/user_session_repository.dart';
import 'bloc.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  final AuthRepository authRepository;
  final UserSessionRepository userSessionRepository;

  UserSessionBloc({
    @required this.authRepository,
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
    }
    // else if (event is LoggedOut) {
    //   yield* _mapLoggedOutToState();
    // }
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

  // Stream<UserSessionState> _mapLoggedOutToState() async* {
  //   yield Unauthenticated();
  //   _userRepository.signOut();
  // }
}
