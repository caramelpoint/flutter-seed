import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:caramelseed/core/widgets/onBoarding/onboarding.dart';
import 'package:caramelseed/features/authentication/presentation/pages/login_page.dart';
import 'package:caramelseed/features/item_list/presentation/pages/item_list_page.dart';

import '../../main.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  MainPage mainPageRoute;

  @CustomRoute(transitionsBuilder: TransitionsBuilders.slideLeftWithFade, durationInMilliseconds: 325)
  OnboardingPage onboardingPageRoute;
  @CustomRoute(transitionsBuilder: TransitionsBuilders.slideLeftWithFade, durationInMilliseconds: 325)
  LoginPage loginPageRoute;
  @CustomRoute(transitionsBuilder: TransitionsBuilders.slideLeftWithFade, durationInMilliseconds: 325)
  ItemListPage itemListPageRoute;
}
