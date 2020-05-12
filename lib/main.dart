import 'package:auto_route/auto_route.dart';
import 'package:caramelseed/core/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routing/router.gr.dart';
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
          child: ExtendedNavigator<Router>(router: Router()),
        );
      },
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
              ExtendedNavigator.ofRouter<Router>().pushReplacementNamed(Routes.onboardingPageRoute);
            });
          } else {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ExtendedNavigator.ofRouter<Router>().pushReplacementNamed(Routes.loginPageRoute);
            });
          }
        }
        if (state is Authenticated) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ExtendedNavigator.ofRouter<Router>().pushReplacementNamed(Routes.itemListPageRoute);
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
