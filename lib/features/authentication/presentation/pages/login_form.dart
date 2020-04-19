import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/size_config.dart';
import '../../../../core/util/snackbar.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/logo.dart';
import '../../domain/usecases/login/bloc.dart';
import '../../domain/usecases/user_session/bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  bool get isPopulated => _emailController.value.text.isNotEmpty && _passwordController.value.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is ErrorLoginState) {
          SnackbarUtil.hideCurrentSnackBar(context);
          SnackbarUtil.showSnakbar(
            context: context,
            text: state.message,
            type: SnackbarUtil.ERROR,
          );
        }
        if (state is AuthenticatingState) {
          SnackbarUtil.showSnakbar(
            duration: 20,
            context: context,
            text: state.message,
          );
        }
        if (state is AuthorizedState) {
          SnackbarUtil.hideCurrentSnackBar(context);
          BlocProvider.of<UserSessionBloc>(context).add(LoggedIn());
        }
        if (state is LoginInvalidValuesState) {
          SnackbarUtil.showSnakbar(
            duration: 1,
            context: context,
            text: state.message,
            type: SnackbarUtil.ERROR,
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Form(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.safeBlockVertical * 30),
                    // const Logo(),
                    InputField(
                      controller: _emailController,
                      icon: Icons.alternate_email,
                      key: const Key('Email'),
                      fieldLabel: 'Email',
                      fieldName: 'Email',
                      textInputType: TextInputType.emailAddress,
                      activeColor: Theme.of(context).accentColor,
                      hidden: false,
                      validatorFn: (_) {
                        return !state.isEmailValid ? 'Email Inválido' : null;
                      },
                    ),
                    InputField(
                      controller: _passwordController,
                      icon: Icons.lock_outline,
                      key: const Key('Password'),
                      fieldLabel: 'Contraseña',
                      fieldName: 'Password',
                      textInputType: TextInputType.text,
                      activeColor: Theme.of(context).accentColor,
                      hidden: true,
                      validatorFn: (_) {
                        return !state.isPasswordValid ? 'Contraseña Incorrecta, al menos 6 caractéres.' : null;
                      },
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 5),
                    Button(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).backgroundColor,
                      text: 'Ingresar',
                      onPressed: () {
                        _onSubmitClick(isFormValid: state.isEmailValid && state.isPasswordValid);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onSubmitClick({bool isFormValid}) {
    _voidHideKeyboard();
    if (isPopulated && isFormValid) {
      _loginBloc.add(
        LoginWithCredentials(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    } else {
      _loginBloc.add(
        LoginInvalidValues(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  void _voidHideKeyboard() {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
