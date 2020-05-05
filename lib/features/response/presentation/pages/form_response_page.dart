import 'package:caramelseed/features/response/domain/entities/form_template.dart';
import 'package:caramelseed/features/response/domain/usecases/response_page/response_page_bloc.dart';
import 'package:caramelseed/features/response/domain/usecases/response_page/response_page_event.dart';
import 'package:caramelseed/features/response/domain/usecases/response_page/response_page_state.dart';
import 'package:caramelseed/features/response/domain/usecases/stepper_response/stepper_response_bloc.dart';
import 'package:caramelseed/features/response/domain/usecases/stepper_response/stepper_response_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/size_config.dart';
import '../../../../core/util/snackbar.dart';
import '../../../../core/widgets/spinner.dart';
import '../../../../injection_container.dart';

import '../widgets/response_stepper.dart';

class FormResponsePage extends StatelessWidget {
  const FormResponsePage({
    Key key,
    @required this.formTemplate,
  }) : super(key: key);

  final FormTemplate formTemplate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        iconTheme: IconThemeData(
          color: theme.colorScheme.secondary,
        ),
      ),
      body: Center(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ResponsePageBloc>(
              create: (BuildContext context) =>
                  injector<ResponsePageBloc>()..add(SaveFormResponse(formTemplate: formTemplate)),
            ),
            BlocProvider<StepperResponseBloc>(create: (BuildContext context) => injector<StepperResponseBloc>()
                // ..add(StartNewFormResponse(formTemplate: formTemplate)),
                ),
          ],
          child: BlocListener<ResponsePageBloc, ResponsePageState>(
            listener: (BuildContext context, ResponsePageState state) {
              if (state is SavingFormResponse) {
                SnackbarUtil.hideCurrentSnackBar(context);
                SnackbarUtil.showSnakbar(
                  context: context,
                  text: state.message,
                  type: SnackbarUtil.ERROR,
                );
              }
              if (state is FormResponseSaved) {
                SnackbarUtil.hideCurrentSnackBar(context);
                SnackbarUtil.showSnakbar(
                  context: context,
                  text: state.message,
                );
                BlocProvider.of<StepperResponseBloc>(context)
                    .add(StartStepperResponse(formTemplate: formTemplate, formResponseId: state.formResponse.id));
              }
              if (state is SavingResponses) {
                SnackbarUtil.showSnakbar(
                  duration: 1,
                  context: context,
                  text: state.message,
                );
              }
              if (state is ResponsesSaved) {
                SnackbarUtil.showSnakbar(
                  context: context,
                  duration: 1,
                  text: "Respuestas Guardadas",
                );
                Future.delayed(
                  const Duration(seconds: 1),
                  () => Navigator.of(context).pop(),
                );
              }
            },
            child: BlocBuilder<ResponsePageBloc, ResponsePageState>(
              builder: (BuildContext context, ResponsePageState state) {
                if (state is SavingFormResponse) {
                  return const Spinner();
                }
                return const ResponseStepper();
              },
            ),
          ),
        ),
      ),
    );
  }
}
