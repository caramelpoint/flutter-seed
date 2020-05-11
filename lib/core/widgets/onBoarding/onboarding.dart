import 'package:caramelseed/core/config/size_config.dart';
import 'package:caramelseed/features/authentication/domain/usecases/user_session/user_session_bloc.dart';
import 'package:caramelseed/features/authentication/domain/usecases/user_session/user_session_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_navigation.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    final List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    final theme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1),
      height: SizeConfig.blockSizeVertical * 1.2,
      width: isActive ? SizeConfig.blockSizeHorizontal * 10 : SizeConfig.blockSizeHorizontal * 5,
      decoration: BoxDecoration(
        color: isActive ? theme.primary : theme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.ease,
    );
  }

  void _skipOnBoarding(BuildContext context) {
    print("Skip OnBoarding");
    BlocProvider.of<UserSessionBloc>(context).add(Onboarded());
    Navigator.of(context).pushNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                const Center(
                  child: Text("Page 1"),
                ),
                const Center(
                  child: Text("Page 2"),
                ),
                const Center(
                  child: Text("Page 3"),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          if (_currentPage != _numPages - 1)
            OnBoardingNavigation(
              skipFunction: () => {_skipOnBoarding(context)},
              nextFunction: () => {_nextPage()},
            )
          else
            OnBoardingNavigation(
              skipFunction: () => {_skipOnBoarding(context)},
              nextFunction: () => {_skipOnBoarding(context)},
            ),
        ],
      ),
    );
  }
}
