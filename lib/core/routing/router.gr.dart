// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:caramelseed/main.dart';
import 'package:caramelseed/core/widgets/onBoarding/onboarding.dart';
import 'package:caramelseed/features/authentication/presentation/pages/login_page.dart';
import 'package:caramelseed/features/item_list/presentation/pages/item_list_page.dart';

abstract class Routes {
  static const mainPageRoute = '/';
  static const onboardingPageRoute = '/onboarding-page-route';
  static const loginPageRoute = '/login-page-route';
  static const itemListPageRoute = '/item-list-page-route';
  static const all = {
    mainPageRoute,
    onboardingPageRoute,
    loginPageRoute,
    itemListPageRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator => ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.mainPageRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MainPage(),
          settings: settings,
        );
      case Routes.onboardingPageRoute:
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) => OnboardingPage(),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          transitionDuration: const Duration(milliseconds: 325),
        );
      case Routes.loginPageRoute:
        if (hasInvalidArgs<LoginPageArguments>(args)) {
          return misTypedArgsRoute<LoginPageArguments>(args);
        }
        final typedArgs = args as LoginPageArguments ?? LoginPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(key: typedArgs.key),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          transitionDuration: const Duration(milliseconds: 325),
        );
      case Routes.itemListPageRoute:
        if (hasInvalidArgs<ItemListPageArguments>(args)) {
          return misTypedArgsRoute<ItemListPageArguments>(args);
        }
        final typedArgs = args as ItemListPageArguments ?? ItemListPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) => ItemListPage(key: typedArgs.key),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          transitionDuration: const Duration(milliseconds: 325),
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//LoginPage arguments holder class
class LoginPageArguments {
  final Key key;
  LoginPageArguments({this.key});
}

//ItemListPage arguments holder class
class ItemListPageArguments {
  final Key key;
  ItemListPageArguments({this.key});
}
