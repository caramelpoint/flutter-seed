import 'package:caramelseed/features/fbAuth/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'features/fbAuth/bloc/authentication_bloc/bloc.dart';
import 'features/fbAuth/bloc/simple_bloc_delegate.dart';
import 'features/fbAuth/ui/home_screen.dart';
import 'features/fbAuth/ui/login/login_screen.dart';
import 'features/fbAuth/ui/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final UserRepository userRepository = UserRepository();
  runApp(BlocProvider(
    create: (context) => AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          if (state is Authenticated) {
            return HomeScreen(
              name: state.displayName,
            );
          }
          if (state is Unauthenticated) {
            return LoginScreen(
              userRepository: _userRepository,
            );
          }
          return Container();
        },
      ),
    );
  }
}
