import 'package:flutter/material.dart';

mixin TestUtil {
  static Widget makeTesteableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }
}
