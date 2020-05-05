import 'package:caramelseed/core/config/size_config.dart';
import 'package:caramelseed/core/widgets/button_flat.dart';
import 'package:flutter/material.dart';

const String BACK_BUTTON_LABEL = "Volver";
const String CONTINUE_BUTTON_LABEL = "Continuar";

class StepperControls extends StatelessWidget {
  final VoidCallback onStepContinue;
  final VoidCallback onStepCancel;

  const StepperControls({this.onStepContinue, this.onStepCancel});
  @override
  Widget build(BuildContext context) {
    debugPrint('Building $this');
    SizeConfig.init(context);
    final ThemeData theme = Theme.of(context);
    return Row(
      children: <Widget>[
        ButtonFlat(
          text: BACK_BUTTON_LABEL,
          onPressed: onStepCancel,
          splahsColor: theme.primaryColor,
          textColor: theme.selectedRowColor,
        ),
        ButtonFlat(
          text: CONTINUE_BUTTON_LABEL,
          onPressed: onStepContinue,
          splahsColor: theme.primaryColor,
          textColor: theme.primaryColor,
        ),
      ],
    );
  }
}
