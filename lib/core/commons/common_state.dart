abstract class CommonState {}

abstract class LoadingState implements CommonState {
  const LoadingState(this.message);

  final String message;
}

abstract class ErrorState implements CommonState {
  const ErrorState(this.message);

  final String message;
}
