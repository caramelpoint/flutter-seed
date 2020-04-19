import 'package:flutter/widgets.dart';

mixin SizeConfig {
  // MediaQueryData which holds the information of the current media,
  // among which there is the size of our screen.
  static MediaQueryData _mediaQueryData;
  // Usefull width and height screen.
  static double screenWidth;
  static double screenHeight;
  // Sizes of block of our grid UI.
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  // SafeArea, UI's part when you should put your components.
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  // Used to scale the Text Horizontally
  static double safeBlockHorizontal;
  // Used to scale the Text Vertically
  static double safeBlockVertical;
  // Device Pixel Ratio
  static double devicePixelRatio;
  // Text Scale Factor
  static double textScaleFactor;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    devicePixelRatio = _mediaQueryData.devicePixelRatio;
    textScaleFactor = _mediaQueryData.textScaleFactor;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
