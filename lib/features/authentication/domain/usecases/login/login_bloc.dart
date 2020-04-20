import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/commons/common_error_msg.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/util/validators.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/user_session_repository.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final UserSessionRepository userSessionRepository;

  LoginBloc({
    @required this.authRepository,
    @required this.userSessionRepository,
  });

  @override
  LoginState get initialState => const InitialLoginState();

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    final Stream<LoginEvent> nonDebounceStream = events.where((LoginEvent event) {
      return event is! EmailChanged && event is! PasswordChanged;
    });
    final Stream<LoginEvent> debounceStream = events.where((LoginEvent event) {
      return event is EmailChanged || event is PasswordChanged;
    }).debounceTime(const Duration(milliseconds: 300));

    return super.transformEvents(
      nonDebounceStream.mergeWith(<Stream<LoginEvent>>[debounceStream]),
      next,
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginInvalidValues) {
      yield* _mapLoginInvalidValuesToState(event.email, event.password);
    } else if (event is LoginWithCredentials) {
      yield* _mapLoginWithCredentialsToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapLoginInvalidValuesToState(String email, String password) async* {
    yield LoginInvalidValuesState(
      msg: CommonErrorMessage.LOGIN_UNCOMPLETED_FIELDS,
      emailValid: Validators.isValidEmail(email),
      passwordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithCredentialsToState({
    String email,
    String password,
  }) async* {
    yield const AuthenticatingState(msg: CommonErrorMessage.AUTHENTICATING_MESSAGE);
    final Either<Failure, User> failureOrUser = await authRepository.login(Params(email: email, password: password));
    yield failureOrUser.fold(
      (failure) => ErrorLoginState(msg: _mapFailureToMessage(failure)),
      (user) {
        userSessionRepository.saveUserLogged(user);
        return AuthorizedState(user);
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NoConnectionFailure:
        return CommonErrorMessage.NO_CONNECTION_FAILURE_MESSAGE;
      case LoginFailure:
        return CommonErrorMessage.LOGIN_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}