import 'package:flutter/material.dart';

const Color primary = Color(0xFF69D0E5);
// ALERTS
const Color successColor = Color(0xFF27AE60);
const Color errorColor = Color(0xFFFF0000);
// SECONDARIES
const Color secondary_1 = Color(0xFF2D0753);
const Color secondary_2 = Color(0xFF958074);
// GRAY SCALES
const Color textColor = Color(0xFF5C5B5A);
const Color textColorVariant_1 = Color(0xFFBEBEBE);
const Color textColorVariant_2 = Color(0xFFAAAAAA);
const Color background = Color(0xFFF8F8F8);
const Color white = Color(0xFFFFFFFF);

//Material Scale
const int baseColor = 0xFF37BBED;
const Map<int, Color> mapColor = <int, Color>{
  50: Color(0xFFf7ccc7),
  100: Color(0xFFf6c1bb),
  200: Color(0xFFf4b7b0),
  300: Color(0xFFf3ada5),
  400: Color(0xFFf1a39a),
  500: Color(0xFFF0998F), //PRimary Color
  600: Color(0xFFd88980),
  700: Color(0xFFc07a72),
  800: Color(0xFFa86b64),
  900: Color(0xFF905b55),
};
const MaterialColor materialColor = MaterialColor(baseColor, mapColor);

class MainTheme {
  static ThemeData init() {
    return ThemeData(
      primaryColor: primary,
      primarySwatch: materialColor,
      errorColor: errorColor,
      cursorColor: textColor,
      cardColor: white,
      accentColor: secondary_1,
      disabledColor: textColorVariant_2,
      splashColor: primary,
      selectedRowColor: textColorVariant_1,
      primaryColorLight: primary,
      backgroundColor: background,
      buttonColor: primary,
      colorScheme: ColorScheme(
        primary: primary,
        primaryVariant: mapColor[50],
        secondary: secondary_1,
        secondaryVariant: secondary_2,
        surface: textColorVariant_1,
        background: background,
        error: errorColor,
        onPrimary: primary,
        onError: errorColor,
        onSecondary: secondary_1,
        onSurface: textColor,
        onBackground: background,
        brightness: Brightness.light,
      ),
      fontFamily: 'Roboto',
      textTheme: TextTheme(
        // H1
        headline4: TextStyle(
          fontSize: 34,
          letterSpacing: -1.5,
          fontStyle: FontStyle.normal,
          color: textColor,
          fontWeight: FontWeight.w900, // Black
        ),
        // H2
        headline3: TextStyle(
          fontSize: 28,
          letterSpacing: -0.5,
          fontStyle: FontStyle.normal,
          color: textColor,
          fontWeight: FontWeight.normal, // Medium
        ),
        // H3
        headline2: TextStyle(
          fontSize: 32,
          letterSpacing: -0.04,
          fontStyle: FontStyle.normal,
          color: textColor,
          fontWeight: FontWeight.w900, // Black
        ),
        // H4
        headline1: TextStyle(
          fontSize: 16,
          letterSpacing: 0.25,
          fontStyle: FontStyle.normal,
          color: textColor,
          fontWeight: FontWeight.normal, // Black
        ),
        // Title
        headline6: TextStyle(
          fontSize: 22,
          letterSpacing: 0,
          fontStyle: FontStyle.normal,
          color: textColor,
          fontWeight: FontWeight.w700, // Bold
        ),
        // Subtitle
        subtitle2: TextStyle(
          fontSize: 20,
          letterSpacing: 0.25,
          fontStyle: FontStyle.normal,
          color: textColor,
          fontWeight: FontWeight.w600, // Bold
        ),
        // Headline
        headline5: TextStyle(
          fontSize: 18,
          // letterSpacing: 0.15,
          fontStyle: FontStyle.normal,
          color: textColor,
          fontWeight: FontWeight.normal, // Normal
        ),
        // Subtitle 2
        subtitle1: TextStyle(
          fontSize: 14,
          letterSpacing: 0.1,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500, // Medium
        ),
        // Body1
        bodyText2: TextStyle(
          fontSize: 16,
          letterSpacing: 0.5,
          fontStyle: FontStyle.normal,
          color: textColor,
          fontWeight: FontWeight.normal, // Regular
        ),
        // Body2
        bodyText1: TextStyle(
          fontSize: 13,
          // letterSpacing: 0.25,
          fontStyle: FontStyle.normal,
          color: textColor,
          fontWeight: FontWeight.normal,
        ),
        //  Button
        button: TextStyle(
          fontSize: 16,
          letterSpacing: 0.5,
          fontStyle: FontStyle.normal,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
        caption: TextStyle(
          fontSize: 12,
          letterSpacing: 0.4,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400, // Regular
          color: textColor,
        ),
        overline: TextStyle(
          fontSize: 12,
          letterSpacing: 2,
          fontStyle: FontStyle.normal,
          color: textColor,
          fontWeight: FontWeight.w500, // Medium
        ),
      ),
    );
  }
}
