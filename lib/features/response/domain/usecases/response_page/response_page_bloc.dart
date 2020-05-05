import 'package:caramelseed/core/commons/common_messages.dart';
import 'package:caramelseed/features/response/domain/entities/form_response.dart';
import 'package:caramelseed/features/response/domain/entities/form_template.dart';
import 'package:caramelseed/features/response/domain/usecases/response_page/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../repositories/create_form_response_repository.dart';

class ResponsePageBloc extends Bloc<ResponsePageEvent, ResponsePageState> {
  final CreateFormResponseRepository formResponseRepository;

  ResponsePageBloc({@required this.formResponseRepository});

  @override
  ResponsePageState get initialState => const ResponsePageInitial();

  @override
  Stream<ResponsePageState> mapEventToState(
    ResponsePageEvent event,
  ) async* {
    if (event is SaveFormResponse) {
      yield* _mapSaveFormResponseToState(event.formTemplate);
    }
    if (event is SaveResponses) {
      yield* _mapSaveFormResponsesToState();
    }
  }

  Stream<ResponsePageState> _mapSaveFormResponseToState(FormTemplate formTemplate) async* {
    yield const SavingFormResponse();
    final Either<Failure, FormResponse> formResponseFailureOrResponse =
        //TODO Refactor, send fields or object necessary to fullfil SUBJECT, FORMTEMPLATENAME, FORMTEMPLATEID, AGENT, STATUS
        await formResponseRepository.createFormResponse(formTemplate);
    // // AVOID creating new response
    //     await Future.delayed(
    //   const Duration(seconds: 3),
    //   () => Right(
    //     const FormResponse(id: "1"),
    //   ),
    // );
    yield* formResponseFailureOrResponse.fold(
      (failure) async* {
        // TODO
        debugPrint(CommonMessage.SAVING_FORM_RESPONSE_ERROR);
      },
      (formResponse) async* {
        debugPrint(CommonMessage.SAVING_FORM_RESPONSE_SUCCESS);
        yield FormResponseSaved(formResponse: formResponse);
      },
    );
  }

  Stream<ResponsePageState> _mapSaveFormResponsesToState() async* {
    yield const SavingResponses();
    //Call repository and save formResponses (locally or remotly)
    final int sl = await Future.delayed(const Duration(seconds: 2), () => 1);
    if (sl == 1) {
      //Finish saving
      yield ResponsesSaved();
    } else {
      //Error
      yield ErrorSavingResponses();
    }
  }
}
