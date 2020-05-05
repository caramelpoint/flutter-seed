import 'package:caramelseed/features/response/domain/entities/form_response.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/commons/common_messages.dart';
import '../../../../../core/commons/common_state.dart';

abstract class ResponsePageState extends Equatable {
  const ResponsePageState();

  @override
  List<Object> get props => [];

  @override
  String toString() => '{ ResponseState }';
}

class ResponsePageInitial extends ResponsePageState {
  const ResponsePageInitial();

  @override
  String toString() => '{ ResponeInitial }';
}

class SavingFormResponse extends ResponsePageState implements LoadingState {
  const SavingFormResponse();

  @override
  String toString() => '{ SavingFormResponse }';
  @override
  String get message => CommonMessage.SAVING_FORM_RESPONSE;
}

class FormResponseSaved extends ResponsePageState {
  final FormResponse formResponse;
  const FormResponseSaved({this.formResponse});

  @override
  String toString() => '{ FormResponseSaved }';
  String get message => CommonMessage.SAVING_FORM_RESPONSE_SUCCESS;
}

class ErrorSavingFormResponse extends ResponsePageState implements LoadingState {
  const ErrorSavingFormResponse();

  @override
  String toString() => '{ ErrorSavingFormResponse }';
  @override
  String get message => CommonMessage.SAVING_FORM_RESPONSE_ERROR;
}

class SavingResponses extends ResponsePageState implements LoadingState {
  const SavingResponses();
  @override
  String toString() => 'SavingResponses ${super.toString()}';

  @override
  String get message => CommonMessage.SAVING_FORM_RESPONSES;
}

class ResponsesSaved extends ResponsePageState {
  @override
  String toString() => 'ResponsesSaved ${super.toString()}';
}

class ErrorSavingResponses extends ResponsePageState implements ErrorState {
  @override
  String toString() => 'ErrorSavingResponses ${super.toString()}';

  @override
  String get message => CommonMessage.SAVING_FORM_RESPONSES_ERROR;
}
