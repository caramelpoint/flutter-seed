import 'package:caramelseed/features/response/domain/entities/question_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/size_config.dart';
import '../../domain/entities/response.dart';
import '../../domain/usecases/stepper_response/bloc.dart';
import 'input_field.dart';
import 'stepper_controls.dart';

class StepContent extends StatelessWidget {
  final QuestionTemplate questionTemplate;
  final InputController inputController = InputController();

  StepContent(this.questionTemplate);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<StepperResponseBloc, StepperResponseState>(
        builder: (BuildContext context, StepperResponseState state) {
      return Column(
        children: <Widget>[
          Card(
            elevation: 4,
            child: Container(
              margin: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 1),
              padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 2,
                      right: SizeConfig.safeBlockHorizontal * 1,
                      top: SizeConfig.safeBlockHorizontal * 1,
                      bottom: SizeConfig.safeBlockHorizontal * 1,
                    ),
                    child: Text(
                      "${questionTemplate.order}. ${questionTemplate.question}",
                      style: theme.textTheme.headline.copyWith(color: theme.cursorColor),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 4,
                      right: SizeConfig.safeBlockHorizontal * 1,
                      top: SizeConfig.safeBlockHorizontal * 1,
                      bottom: SizeConfig.safeBlockHorizontal * 1,
                    ),
                    color: Colors.transparent,
                    child: InputField(
                      inputController: inputController,
                      currentResponse: state.currentResponse,
                      dataType: state.questionTemplate.dataType,
                    ),
                  ),
                ],
              ),
            ),
          ),
          StepperControls(
            onStepContinue: () => BlocProvider.of<StepperResponseBloc>(context).add(
              NextQuestion(
                responseValue: inputController.currentResponseValue,
                dataType: state.questionTemplate.dataType,
              ),
            ),
            onStepCancel: () => BlocProvider.of<StepperResponseBloc>(context).add(PreviousQuestion()),
          ),
        ],
      );
    });
  }
}

String getResponse(StepperResponseState state) {
  Response returnResponse;
  // returnResponse = state.formResponses[currentCategory][currentQuestion];
  returnResponse = state.currentResponse;
  return returnResponse != null ? returnResponse.response : "";
}

class InputController {
  dynamic currentResponseValue;
}
