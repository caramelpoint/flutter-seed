import 'package:caramelseed/features/response/domain/entities/form_template.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ResponsePageEvent extends Equatable {
  const ResponsePageEvent();

  @override
  List<Object> get props => <List<Object>>[];
}

class SaveFormResponse extends ResponsePageEvent {
  const SaveFormResponse({@required this.formTemplate});

  final FormTemplate formTemplate;

  @override
  List<Object> get props => <Object>[formTemplate];

  @override
  String toString() {
    return 'SaveFormResponse { formTemplate: ${formTemplate.name} }';
  }
}

class SaveResponses extends ResponsePageEvent {}
