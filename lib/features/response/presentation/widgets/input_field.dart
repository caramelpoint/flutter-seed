import 'package:caramelseed/features/response/domain/entities/response.dart';
import 'package:caramelseed/features/response/presentation/widgets/step_content.dart';
import 'package:flutter/material.dart';

import 'inputTypes/number_field.dart';

class InputField extends StatelessWidget {
  final InputController inputController;
  final String dataType;

  InputField({Response currentResponse, this.inputController, this.dataType}) {
    final dynamic responseValue = currentResponse?.response;
    inputController.currentResponseValue = responseValue;
  }
  @override
  Widget build(BuildContext context) {
    return _getInputType(dataType, inputController);
  }
}

Widget _getInputType(String dataType, InputController inputController) {
  Widget inputType;
  switch (dataType) {
    // case 'uniqueOption':
    //   return TagsField(
    //     options: question.options,
    //     isSingleOption: true,
    //     responseStorage: updateResponseFn,
    //   );
    //   break;
    // case 'listOption':
    //   return TagsField(
    //     options: question.options,
    //     isSingleOption: false,
    //     responseStorage: updateResponseFn,
    //   );
    case 'string':
      inputController.currentResponseValue = inputController.currentResponseValue ?? "";
      inputType = TextField(
        controller: TextEditingController(text: "${inputController.currentResponseValue}"), // ${getResponse(state)}
        onChanged: (value) {
          print('Changed $value');
          inputController.currentResponseValue = value;
        },
      );
      break;
    case 'number':
      inputController.currentResponseValue = inputController.currentResponseValue ?? 0;
      return NumberField(
        inputController: inputController,
      );
      break;

    // case 'date':
    //   return DatePicker(
    //     responseStorage: updateResponseFn,
    //   );
    // case 'file':
    //   return Container();
    // case 'boolean':
    //   return BooleanField(
    //     responseStorage: updateResponseFn,
    //   );
    default:
      inputType = Container();
      break;
  }
  return inputType;
}
