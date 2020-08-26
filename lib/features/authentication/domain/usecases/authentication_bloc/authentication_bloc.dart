import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:caramelseed/features/authentication/domain/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  final UserSessionRepository userSessionRepository;


  AuthenticationBloc({@required this.authRepository, @required this.userSessionRepository});

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is SignIn) {
      yield* _mapSignInToState();
    } else if (event is SignOut) {
      yield* _mapSignOutToState();
    } else if (event is Onboarded) {
      yield* _mapOnBoardedToState();
    }
  }

  Future<bool> _getIsFirstLoad() async {
    final Either<Failure, bool> failureOrIsFirstLoad = await userSessionRepository.getIsFirstLoad();
    if (failureOrIsFirstLoad.isRight()) {
      return failureOrIsFirstLoad.getOrElse(null);
    }
    return true;
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final bool isFirstLoad = await _getIsFirstLoad();

    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final user = await _userRepository.getUser();
        yield await Future.delayed(Duration(seconds: 5), () {
          return Authenticated(user);
        });
      } else {
        yield await Future.delayed(Duration(seconds: 5), () {
          return Unauthenticated();
        });
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await _userRepository.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
