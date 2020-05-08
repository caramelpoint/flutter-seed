import 'package:caramelseed/core/routing/routes.dart';
import 'package:caramelseed/core/widgets/onBoarding/onboarding.dart';
import 'package:caramelseed/features/authentication/presentation/pages/login_page.dart';
import 'package:caramelseed/features/item_list/presentation/pages/item_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

import '../../main.dart';

class AppNavigation {
  PageTransition<dynamic> getTransition(RouteSettings settings, Widget child) {
    return PageTransition<dynamic>(
      child: child,
      type: PageTransitionType.rightToLeftWithFade,
      duration: const Duration(milliseconds: 325),
      settings: settings,
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return getTransition(settings, MainPage());
        break;
      case ONBOARDING_ROUTE:
        return getTransition(settings, OnboardingPage());
        break;
      case LOGIN_ROUTE:
        return getTransition(settings, const LoginPage());
        break;
      case LIST_ROUTE:
        return getTransition(settings, const ItemListPage());
        break;
      default:
        return getTransition(settings, Center(child: Text('No route defined for ${settings.name}')));
        break;
    }
  }
}
