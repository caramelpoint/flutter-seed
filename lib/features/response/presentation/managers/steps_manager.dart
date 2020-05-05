import 'package:caramelseed/features/response/domain/entities/category_template.dart';
import 'package:caramelseed/features/response/domain/entities/question_template.dart';
import 'package:caramelseed/features/response/presentation/widgets/step_content.dart';
import 'package:caramelseed/features/response/presentation/widgets/step_title.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/response.dart';

class StepManager {
  static List<Step> createStepList({
    List<CategoryTemplate> categoryTemplates,
    int categoryIndex,
    int questionIndex,
    List<List<Response>> formResponses,
  }) {
    debugPrint('BUilding Step list');
    final List<Step> stepList = [];
    for (int i = 0; i < categoryTemplates.length; i++) {
      final CategoryTemplate categoryTemplate = categoryTemplates[i];

      //TODO Update stepState based on Category Template status
      StepState state;
      state = StepState.complete;
      for (final response in formResponses[i]) {
        if (response == null || response.response == "") {
          state = StepState.editing;
          break;
        }
      }
      //TODO Refactor
      Step step;
      if (i == categoryIndex) {
        final QuestionTemplate questionTemplate = categoryTemplate.questionTemplates[questionIndex];
        step = Step(
          title: StepTitle("${i + 1}. ${categoryTemplate.name}"),
          content: StepContent(questionTemplate),
          state: state,
          isActive: true,
        );
      } else {
        step = Step(
          title: StepTitle("${i + 1}. ${categoryTemplate.name}"),
          content: Container(),
          state: state,
        );
      }

      stepList.add(step);
    }
    return stepList;
  }
}
