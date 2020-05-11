import 'package:caramelseed/core/routing/app_navigation.dart';
import 'package:caramelseed/core/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routing/routes.dart';
import 'core/theme/main_theme.dart';
import 'features/authentication/domain/usecases/user_session/bloc.dart';
import 'injection_container.dart';

class MyApp extends StatelessWidget {
  final bool isFirstLoad;
  const MyApp({this.isFirstLoad});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserSessionBloc>(
      create: (_) => injector<UserSessionBloc>()..add(AppStarted()),
      child: App(isFirstLoad: isFirstLoad),
    );
  }
}

class App extends StatelessWidget {
  final bool isFirstLoad;

  const App({Key key, this.isFirstLoad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caramel Seed',
      debugShowCheckedModeBanner: false,
      theme: MainTheme.init(),
      builder: (BuildContext context, Widget child) {
        final MediaQueryData data = MediaQuery.of(context);
        final double shortestSide = MediaQuery.of(context).size.shortestSide;
        final bool useMobileLayout = shortestSide < 600;
        final bool useSmallMobileLayout = shortestSide <= 320;
        return MediaQuery(
          data: data.copyWith(
            textScaleFactor: data.textScaleFactor * (!useMobileLayout ? 1.5 : useSmallMobileLayout ? 0.8 : 1),
          ),
          child: child,
        );
      },
      onGenerateRoute: injector<AppNavigation>().generateRoute,
      initialRoute: ROOT_ROUTE,
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserSessionBloc, UserSessionState>(
      listener: (BuildContext context, UserSessionState state) {
        if (state is Unauthenticated) {
          if (state.isFirstLoad) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(ONBOARDING_ROUTE);
            });
          } else {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(LOGIN_ROUTE);
            });
          }
        }
        if (state is Authenticated) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(LIST_ROUTE);
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          margin: const EdgeInsets.all(600),
          child: const Spinner(),
        ),
      ),
    );
  }
}
