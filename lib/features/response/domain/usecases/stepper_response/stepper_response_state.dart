import 'package:caramelseed/features/response/domain/entities/category_template.dart';
import 'package:caramelseed/features/response/domain/entities/form_template.dart';
import 'package:caramelseed/features/response/domain/entities/question_template.dart';
import 'package:equatable/equatable.dart';
import '../../entities/response.dart';

abstract class StepperResponseState extends Equatable {
  final FormTemplate formTemplate;
  final CategoryTemplate categoryTemplate; //TODO: not being use, maybe remove this.
  final QuestionTemplate questionTemplate; //TODO: not being use, maybe remove this.
  final int categoryIndex;
  final int questionIndex;
  final List<List<Response>> formResponses;
  final String formResponseId;
  final Response currentResponse;

  const StepperResponseState({
    this.formTemplate,
    this.categoryTemplate,
    this.questionTemplate,
    this.categoryIndex,
    this.questionIndex,
    this.currentResponse,
    this.formResponses,
    this.formResponseId,
  });

  @override
  List<Object> get props => [
        formTemplate,
        categoryTemplate,
        questionTemplate,
        categoryIndex,
        questionIndex,
        currentResponse,
        formResponses,
      ];

  @override
  String toString() => ''' { StepperResponseState: $formTemplate,
  categoryTemplate: $categoryTemplate,
  cuestionTemplate: $questionTemplate,
  categoryIndex: $categoryIndex,
  cuestionIndex: $questionIndex,
  formResponses: $formResponses,
  currentResponse: $currentResponse }''';
}

class StepperResponseInitial extends StepperResponseState {
  const StepperResponseInitial(
    FormTemplate formTemplate,
    CategoryTemplate categoryTemplate,
    QuestionTemplate questionTemplate,
    int categoryIndex,
    int cuestionIndex,
  ) : super(
          formTemplate: formTemplate,
          categoryTemplate: categoryTemplate,
          questionTemplate: questionTemplate,
          categoryIndex: categoryIndex,
          questionIndex: cuestionIndex,
        );

  const StepperResponseInitial.initNull()
      : super(
          formTemplate: null,
          categoryTemplate: null,
          questionTemplate: null,
          categoryIndex: null,
          questionIndex: null,
        );

  @override
  String toString() => 'StepperResponseInitial ${super.toString()}';
}

class StepperResponseUpdated extends StepperResponseState {
  const StepperResponseUpdated({
    FormTemplate formTemplate,
    CategoryTemplate categoryTemplate,
    QuestionTemplate questionTemplate,
    String formResponseId,
    int categoryIndex,
    int questionIndex,
    List<List<Response>> formResponses,
    Response currentResponse,
  }) : super(
          formTemplate: formTemplate,
          formResponseId: formResponseId,
          categoryTemplate: categoryTemplate,
          questionTemplate: questionTemplate,
          categoryIndex: categoryIndex,
          questionIndex: questionIndex,
          formResponses: formResponses,
          currentResponse: currentResponse,
        );

  @override
  String toString() => 'FormTemplateUpdated ${super.toString()}';
}
