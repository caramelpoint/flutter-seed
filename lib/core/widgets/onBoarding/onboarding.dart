import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_onboarding_ui/utilities/styles.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  height: 1.2,
);

class _OnboardingPageState extends State<OnboardingPage> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 45.0 : 20.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.pink : Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 800.0,
            child: PageView(
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                Container(
                  color: Colors.green,
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: const Text("Page 1"),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.pink,
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: const Text("Page 2"),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.lightBlue,
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: const Text("Page 3"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          _currentPage != _numPages - 1
              ? Expanded(
                  child: Container(
                    color: Colors.red,
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: FlatButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          _currentPage == _numPages - 1
              ? Container(
                  color: Colors.red,
                  child: Align(
                    alignment: FractionalOffset.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
