import 'package:caramelseed/core/routing/app_navigation.dart';
import 'package:caramelseed/core/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routing/routes.dart';
import 'core/theme/main_theme.dart';
import 'core/widgets/splash_screen.dart';
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
      // home: MainPage(),
      // home: getAuthenticationBlocBuilder(),
      onGenerateRoute: injector<AppNavigation>().generateRoute,
      initialRoute: ROOT_ROUTE,
      // initialRoute: isFirstLoad == true || isFirstLoad == null ? "/onBoarding" : "/onBoarding",
    );
  }

  // Widget getAuthenticationBlocBuilder() {
  //   return BlocBuilder<UserSessionBloc, UserSessionState>(
  //     builder: (BuildContext context, UserSessionState state) {
  //       // if (state is Unauthenticated) {
  //       //   Navigator.of(context).pushReplacementNamed("/login");
  //       // }
  //       // if (state is Authenticated) {
  //       //   Navigator.of(context).pushReplacementNamed("/list");
  //       // }
  //       // return Container();
  //       return SplashScreen();
  //     },
  //   );
  // }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // BlocProvider<UserSessionBloc>(
        //   create: (BuildContext context) => injector<UserSessionBloc>(),
        //   child:
        BlocListener<UserSessionBloc, UserSessionState>(
      listener: (BuildContext context, UserSessionState state) {
        // BlocBuilder<UserSessionBloc, UserSessionState>(
        //   builder: (BuildContext context, UserSessionState state) {
        if (state is Unauthenticated) {
          if (state.isFirstLoad) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(ONBOARDING_ROUTE);
            });
          } else {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              // Navigator.of(context).push(...);
              // Navigator.of(context).pushNamed("/login");
              Navigator.of(context).pushReplacementNamed(LOGIN_ROUTE);
            });
          }
        }
        if (state is Authenticated) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            // Navigator.of(context).push(...);
            Navigator.of(context).pushReplacementNamed(LIST_ROUTE);
          });
        }
        if (state is Uninitialized) {
          print("Loading");
        }
        // return SplashScreen();
        // return Container(child: Text("Holas"));
      },
      child: Container(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body:
              // Center(child: Text("hola")
              Container(
            margin: EdgeInsets.all(600),
            child: Spinner(),
          ),
        ),
      ), //Loading
      // ),
    );
    // );
  }
}
