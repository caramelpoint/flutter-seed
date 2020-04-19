import 'package:flutter/material.dart';
import '../config/size_config.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Image.asset(
      'assets/images/logo.png',
      width: SizeConfig.safeBlockHorizontal * 70,
      height: SizeConfig.safeBlockVertical * 15,
      fit: BoxFit.scaleDown,
    );
  }
}
