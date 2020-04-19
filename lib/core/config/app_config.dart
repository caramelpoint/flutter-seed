import 'package:flutter/material.dart';

import '../../injection_container.dart';
import 'env_config.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    EnvConfig envConfig,
    Widget child,
  }) : super(child: child) {
    injector.registerSingleton<EnvConfig>(envConfig);
  }

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
