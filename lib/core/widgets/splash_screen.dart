import 'package:flutter/material.dart';
import '../config/size_config.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final ThemeData themeInstance = Theme.of(context);
    return Scaffold(
      backgroundColor: themeInstance.primaryColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: SizeConfig.safeBlockHorizontal * 70,
          height: SizeConfig.safeBlockVertical * 15,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
