import 'package:caramelseed/features/response/domain/entities/category_template.dart';
import 'package:caramelseed/features/response/domain/entities/form_template.dart';
import 'package:caramelseed/features/response/domain/entities/question_template.dart';
import 'package:caramelseed/features/response/domain/usecases/stepper_response/stepper_response_state.dart';
import '../../entities/response.dart';

class StepperResponseManager {
  StepperResponseManager();

  List<List<Response>> _initFormResponses(FormTemplate formTemplate) {
    return List.generate(formTemplate.categoryTemplates.length,
        (i) => List.generate(formTemplate.categoryTemplates[i].questionTemplates.length, (j) => null));
  }

  StepperResponseUpdated initFormResponse(FormTemplate formTemplate, String formResponseId) {
    const int categoryIndex = 0;
    const int questionIndex = 0;
    final CategoryTemplate firstCategory = formTemplate.categoryTemplates[categoryIndex];
    final QuestionTemplate firstQuestion = firstCategory.questionTemplates[questionIndex];
    return StepperResponseUpdated(
      formTemplate: formTemplate,
      categoryTemplate: firstCategory,
      questionTemplate: firstQuestion,
      categoryIndex: categoryIndex,
      questionIndex: questionIndex,
      formResponseId: formResponseId,
      formResponses: _initFormResponses(formTemplate),
      currentResponse: null,
    );
  }

  StepperResponseUpdated nextQuestion(StepperResponseState state, Response response) {
    final FormTemplate formTemplate = state.formTemplate;
    final int currentCategoryIndex = state.categoryIndex;
    final int currentQuestionIndex = state.questionIndex;

    final List<List<Response>> newFormResponses = _saveResponseInFormResponses(state, response);

    int categoryIndex;
    int questionIndex;
    final CategoryTemplate currentCategory = formTemplate.categoryTemplates[currentCategoryIndex];
    //Check if there is more questions in the current category
    if (currentCategory.questionTemplates.length - 1 > currentQuestionIndex) {
      categoryIndex = currentCategoryIndex;
      questionIndex = currentQuestionIndex + 1;
    } else {
      //Check if it is the last category
      if (formTemplate.categoryTemplates.length - 1 == currentCategoryIndex) {
        categoryIndex = currentCategoryIndex;
        questionIndex = currentQuestionIndex;
      } else {
        //there is no more questions, change category
        categoryIndex = currentCategoryIndex + 1;
        questionIndex = 0;
      }
    }

    final Response newCurrentResponse = state.formResponses[categoryIndex][questionIndex];
    final CategoryTemplate category = formTemplate.categoryTemplates[categoryIndex];
    final QuestionTemplate question = category.questionTemplates[questionIndex];
    return StepperResponseUpdated(
      formTemplate: formTemplate,
      categoryTemplate: category,
      questionTemplate: question,
      categoryIndex: categoryIndex,
      questionIndex: questionIndex,
      formResponses: newFormResponses,
      formResponseId: state.formResponseId,
      currentResponse: newCurrentResponse,
    );
  }

  StepperResponseUpdated previousQuestion(StepperResponseState state) {
    final FormTemplate formTemplate = state.formTemplate;
    final int currentCategoryIndex = state.categoryIndex;
    final int currentQuestionIndex = state.questionIndex;
    int categoryIndex;
    int questionIndex;
    //Check if the current cuestion is the first one
    if (currentQuestionIndex == 0) {
      //Check if it is the first category
      if (currentCategoryIndex == 0) {
        //Todo Refactor this
        categoryIndex = 0;
        questionIndex = 0;
      } else {
        //there is no more previous questions, change category
        questionIndex = formTemplate.categoryTemplates[currentCategoryIndex - 1].questionTemplates.length - 1;
        categoryIndex = currentCategoryIndex - 1;
      }
    } else {
      categoryIndex = currentCategoryIndex;
      questionIndex = currentQuestionIndex - 1;
    }
    final Response newCurrentResponse = state.formResponses[categoryIndex][questionIndex];
    final CategoryTemplate category = formTemplate.categoryTemplates[categoryIndex];
    final QuestionTemplate question = category.questionTemplates[questionIndex];
    return StepperResponseUpdated(
      formTemplate: formTemplate,
      categoryTemplate: category,
      questionTemplate: question,
      categoryIndex: categoryIndex,
      questionIndex: questionIndex,
      formResponses: state.formResponses,
      formResponseId: state.formResponseId,
      currentResponse: newCurrentResponse,
    );
  }

  StepperResponseUpdated changeCategory(StepperResponseState state, int newCategoryIndex) {
    final FormTemplate formTemplate = state.formTemplate;
    final int categoryIndex = newCategoryIndex;
    const int questionIndex = 0; //TODO: Find the last unanswered question maybe.
    final Response newCurrentResponse = state.formResponses[categoryIndex][questionIndex];
    final CategoryTemplate firstCategory = formTemplate.categoryTemplates[categoryIndex];
    final QuestionTemplate firstQuestion = firstCategory.questionTemplates[questionIndex];
    return StepperResponseUpdated(
      formTemplate: formTemplate,
      categoryTemplate: firstCategory,
      questionTemplate: firstQuestion,
      categoryIndex: categoryIndex,
      questionIndex: questionIndex,
      formResponses: state.formResponses,
      formResponseId: state.formResponseId,
      currentResponse: newCurrentResponse,
    );
  }

  StepperResponseUpdated updateCurrentResponseValue(StepperResponseState state, Response response) {
    return StepperResponseUpdated(
      formTemplate: state.formTemplate,
      categoryTemplate: state.categoryTemplate,
      questionTemplate: state.questionTemplate,
      categoryIndex: state.categoryIndex,
      questionIndex: state.questionIndex,
      formResponses: state.formResponses,
      currentResponse: response,
      formResponseId: state.formResponseId,
    );
  }

  List<List<Response>> _saveResponseInFormResponses(StepperResponseState state, Response response) {
    final List<List<Response>> newFormResponses = [...state.formResponses];
    newFormResponses[state.categoryIndex][state.questionIndex] = response;
    return newFormResponses;
  }
}
