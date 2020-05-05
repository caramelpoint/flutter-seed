import 'package:caramelseed/features/response/domain/entities/form_template.dart';
import 'package:caramelseed/features/response/domain/entities/response.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class StepperResponseEvent extends Equatable {
  const StepperResponseEvent();

  @override
  List<Object> get props => <List<Object>>[];
}

// Change category arbitrary
class ChangeCategory extends StepperResponseEvent {
  final int categoryIndex;

  const ChangeCategory(this.categoryIndex);

  @override
  List<Object> get props => <Object>[categoryIndex];

  @override
  String toString() {
    return 'Moved to another category { categoryIndex : $categoryIndex }';
  }
}

class PreviousQuestion extends StepperResponseEvent {}

class NextQuestion extends StepperResponseEvent {
  final dynamic responseValue;
  final String dataType;

  const NextQuestion({this.responseValue, this.dataType});

  @override
  List<Object> get props => <Object>[responseValue, dataType];

  @override
  String toString() {
    return 'NextQuestion { response: $responseValue $dataType }';
  }
}

class StartStepperResponse extends StepperResponseEvent {
  const StartStepperResponse({@required this.formTemplate, @required this.formResponseId});

  final String formResponseId;
  final FormTemplate formTemplate;

  @override
  List<Object> get props => <Object>[formTemplate];

  @override
  String toString() {
    return 'StartNewFormResponse { formTemplate: ${formTemplate.name} }';
  }
}

class UpdateCurrentResponse extends StepperResponseEvent {
  const UpdateCurrentResponse({@required this.response});

  final Response response;

  @override
  List<Object> get props => <Object>[Response];

  @override
  String toString() {
    return 'UpdateCurrentResponseValue { response: $response }';
  }
}
