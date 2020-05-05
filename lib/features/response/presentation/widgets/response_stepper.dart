import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/button.dart';
import '../../domain/usecases/response_page/bloc.dart';
import '../../domain/usecases/stepper_response/bloc.dart';
import '../managers/steps_manager.dart';

class ResponseStepper extends StatefulWidget {
  const ResponseStepper({Key key}) : super(key: key);

  @override
  _ResponseStepperState createState() => _ResponseStepperState();
}

class _ResponseStepperState extends State<ResponseStepper> {
  StepperResponseBloc stepperResponseBloc;

  @override
  void initState() {
    debugPrint('Init State $this');
    super.initState();
    stepperResponseBloc = BlocProvider.of<StepperResponseBloc>(context);
  }

  @override
  void dispose() {
    debugPrint('Dispose $this');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    debugPrint('BUilding $this');
    return Scaffold(
      body: BlocBuilder<StepperResponseBloc, StepperResponseState>(
        builder: (BuildContext context, StepperResponseState state) {
          debugPrint('BUilding bloc builder $this');
          if (state is StepperResponseUpdated) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Stepper(
                      type: StepperType.vertical,
                      currentStep: state.categoryIndex,
                      onStepTapped: (index) {
                        stepperResponseBloc.add(ChangeCategory(index));
                      },
                      steps: StepManager.createStepList(
                        categoryTemplates: state.formTemplate.categoryTemplates,
                        categoryIndex: state.categoryIndex,
                        questionIndex: state.questionIndex,
                        formResponses: state.formResponses,
                      ),
                      controlsBuilder: (
                        BuildContext context, {
                        VoidCallback onStepContinue,
                        VoidCallback onStepCancel,
                      }) =>
                          Container(),
                    ),
                  ),
                ),
                //TODO add logic to this button and the bloc part
                Button(
                  text: "Guardar",
                  backgroundColor: theme.primaryColor,
                  textColor: theme.backgroundColor,
                  key: const Key('save_form_btn'),
                  onPressed: () {
                    BlocProvider.of<ResponsePageBloc>(context).add(SaveResponses());
                  },
                )
              ],
            );
          } else {
            //TODO Improve message if there is no formTemplate loaded.
            return const Text("Error");
          }
        },
      ),
    );
  }
}
