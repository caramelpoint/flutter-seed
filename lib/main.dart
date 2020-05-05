import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'core/theme/main_theme.dart';
import 'core/widgets/onBoarding/onboarding.dart';
import 'core/widgets/splash_screen.dart';
import 'features/authentication/domain/usecases/user_session/bloc.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/item_list/presentation/pages/item_list_page.dart';
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
      home: getAuthenticationBlocBuilder(
        unauthenticatedChild: OnboardingPage(),
        authenticatedChild: const ItemListPage(),
        loader: SplashScreen(),
      ),
      onGenerateRoute: getRoutes,
      initialRoute: isFirstLoad == true || isFirstLoad == null ? "/login" : "/login",
    );
  }

  Widget getAuthenticationBlocBuilder({Widget authenticatedChild, Widget unauthenticatedChild, Widget loader}) {
    return BlocBuilder<UserSessionBloc, UserSessionState>(
      builder: (BuildContext context, UserSessionState state) {
        if (state is Unauthenticated) {
          return unauthenticatedChild;
        }
        if (state is Authenticated) {
          return authenticatedChild;
        }
        return loader;
      },
    );
  }

  Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/onboarding":
        return getTransition(
          settings,
          OnboardingPage(),
        );
      case '/login':
        return getTransition(
          settings,
          getAuthenticationBlocBuilder(
            unauthenticatedChild: const LoginPage(),
            authenticatedChild: const ItemListPage(),
            loader: SplashScreen(),
          ),
        );
        break;
      case '/home':
        return getTransition(
          settings,
          getAuthenticationBlocBuilder(
            unauthenticatedChild: const LoginPage(),
            authenticatedChild: const ItemListPage(),
            loader: SplashScreen(),
          ),
        );
        break;
      default:
        return null;
    }
  }

  // TODO move to absctract class util
  PageTransition<dynamic> getTransition(RouteSettings settings, Widget child) {
    return PageTransition<dynamic>(
      child: child,
      type: PageTransitionType.rightToLeftWithFade,
      duration: const Duration(milliseconds: 325),
      settings: settings,
    );
  }
}
