import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:caramelseed/core/commons/common_messages.dart';
import 'package:caramelseed/core/error/failures.dart';
import 'package:caramelseed/features/response/domain/entities/category_template.dart';
import 'package:caramelseed/features/response/domain/entities/form_template.dart';
import 'package:caramelseed/features/response/domain/entities/question_template.dart';
import 'package:caramelseed/features/response/domain/usecases/managers/stepper_response_manager.dart';
import 'package:caramelseed/features/response/domain/usecases/stepper_response/stepper_response_event.dart';
import 'package:caramelseed/features/response/domain/usecases/stepper_response/stepper_response_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../entities/response.dart';
import '../../repositories/create_form_response_repository.dart';
import '../../repositories/response_repository.dart';

class StepperResponseBloc extends Bloc<StepperResponseEvent, StepperResponseState> {
  final ResponseRepository repository;
  final CreateFormResponseRepository formResponseRepository;
  final StepperResponseManager stepperResponseManager;

  StepperResponseBloc({
    @required this.repository,
    @required this.formResponseRepository,
    @required this.stepperResponseManager,
  });

  @override //TODO check this initNull
  StepperResponseState get initialState => const StepperResponseInitial.initNull();

  @override
  Stream<StepperResponseState> mapEventToState(
    StepperResponseEvent event,
  ) async* {
    if (event is StartStepperResponse) {
      yield stepperResponseManager.initFormResponse(event.formTemplate, event.formResponseId);
    }
    if (event is NextQuestion) {
      yield* _mapNextQuestionToState(state, event.responseValue, event.dataType);
    }
    if (event is PreviousQuestion) {
      yield stepperResponseManager.previousQuestion(state);
    }
    if (event is ChangeCategory) {
      yield stepperResponseManager.changeCategory(state, event.categoryIndex);
    }
  }

  Stream<StepperResponseState> _mapNextQuestionToState(
    StepperResponseState state,
    dynamic responseValue,
    String dataType,
  ) async* {
    // // AVOID SAVING RESPONSE
    // yield StepperResponseManager.nextQuestion(
    //     state,
    //     _parseResponseValue(
    //       responseValue,
    //       dataType,
    //     ));
    // TODO: Saving Response loading: yield const SavingResponseState(msg: CommonMessages.SAVING_USER_SESSION_ERROR);
    final Response newResponse = _parseResponseValue(responseValue, dataType);
    final bool isNewResponseNullOrEmpty = newResponse == null;
    if (isNewResponseNullOrEmpty) {
      yield stepperResponseManager.nextQuestion(state, newResponse);
    } else {
      final Response buildtResponse = buildResponse(state, newResponse);
      final Either<Failure, Response> saveResponseFailureOrResponse = await repository.saveResponse(buildtResponse);
      yield* saveResponseFailureOrResponse.fold(
        (failure) async* {
          //TODO: Saving Response error: yield const ErrorSavingResponseState(msg: CommonMessages.SAVING_RESPONSE_ERROR);
          print(CommonMessage.SAVING_RESPONSE_ERROR);
        },
        (response) async* {
          //TODO: Saving Response success: yield const SuccessfullySavedResponseState(msg: CommonMessages.SAVING_RESPONSE_SUCCESS);
          print(CommonMessage.SAVING_RESPONSE_SUCCESS);
          yield stepperResponseManager.nextQuestion(state, newResponse);
        },
      );
    }
  }

  //Return Response from ResponseValue, null if ResponseValue is [Empty, Void]
  Response _parseResponseValue(dynamic responseValue, String dataType) {
    Response parsedResponse;
    switch (dataType) {
      case "string":
        final String valueParsed = responseValue as String;
        if (valueParsed.isNotEmpty) {
          parsedResponse = Response(response: valueParsed);
        }
        break;
      case "int":
        final int valueParsed = responseValue as int;
        parsedResponse = Response(response: valueParsed.toString());
        break;
    }
    return parsedResponse;
  }

  Response buildResponse(StepperResponseState state, Response response) {
    final CategoryTemplate categoryTemplate = state.categoryTemplate;
    final QuestionTemplate questionTemplate = state.questionTemplate;
    final FormTemplate formTemplate = state.formTemplate;
    final Response buildtresponse = Response(
      response: response.response,
      formTemplateId: formTemplate.id,
      formTemplateName: formTemplate.name,
      formTemplateDescription: formTemplate.description,
      categoryTemplateId: categoryTemplate.id,
      categoryTemplateName: categoryTemplate.name,
      categoryTemplateDescription: categoryTemplate.description,
      questionTemplateId: questionTemplate.id,
      questionTemplateQuestion: questionTemplate.question,
      questionTemplateOrder: questionTemplate.order,
      questionTemplateDataType: questionTemplate.dataType,
      //TODO: Review this fields
      optionTemplateId: "1",
      optionTemplateValue: "1",
      optionTemplateOrder: 1,
    );

    return buildtresponse;
  }
}
