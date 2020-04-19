import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

mixin SnackbarUtil {
  static const String SUCCESS = 'Success';
  static const String ERROR = 'Error';

  static void hideCurrentSnackBar(BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
  }

  // * By Default is a Loading Snackbar
  static void showSnakbar({BuildContext context, String text, String type, int duration}) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(seconds: duration ?? 3),
          elevation: 4,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _getIconOrLoader(type, context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _getText(type, text, context),
              ),
            ],
          ),
          backgroundColor: _getColor(type, context),
        ),
      );
  }

  // * By Default is a Loading Snackbar
  static Widget _getIconOrLoader(String type, BuildContext context) {
    if (type == SUCCESS) {
      return const Icon(Icons.check);
    }
    if (type == ERROR) {
      return Icon(
        Icons.error,
        size: 35,
        color: Theme.of(context).colorScheme.primaryVariant,
      );
    }
    return SpinKitPumpingHeart(
      color: Theme.of(context).colorScheme.primary,
      size: 35.0,
    );
  }

  // * By Default is a Loading Snackbar
  static Color _getColor(String type, BuildContext context) {
    if (type == SUCCESS) {
      return Theme.of(context).colorScheme.secondaryVariant;
    }
    if (type == ERROR) {
      return Theme.of(context).cardColor;
    }
    return Theme.of(context).cardColor;
  }

  // * By Default is a Loading Snackbar
  static Widget _getText(String type, String text, BuildContext context) {
    if (type == SUCCESS) {
      return Text(
        text,
        style: Theme.of(context).textTheme.body1,
      );
    }
    if (type == ERROR) {
      return Text(
        text,
        style: Theme.of(context).textTheme.body1.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      );
    }
    return Text(
      text,
      style: Theme.of(context).textTheme.headline,
    );
  }
}
