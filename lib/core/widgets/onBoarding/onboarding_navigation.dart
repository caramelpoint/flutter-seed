import 'package:caramelseed/core/config/size_config.dart';
import 'package:flutter/material.dart';

class OnBoardingNavigation extends StatelessWidget {
  final Function skipFunction;
  final Function nextFunction;

  const OnBoardingNavigation({this.skipFunction, this.nextFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              skipFunction();
            },
            child: const Text('Skip'),
          ),
          FlatButton(
            onPressed: () {
              nextFunction();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Next',
                ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: SizeConfig.blockSizeHorizontal * 7,
                  // size: 30.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
