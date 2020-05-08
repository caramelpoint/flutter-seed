import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'core/bloc/simple_bloc_delegate.dart';
import 'core/config/app_config.dart';
import 'core/config/env_config.dart';
import 'injection_container.dart' as injector_container;
import 'main.dart';

bool isFirstLoad = true;

// void _getOnboarding() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   isFirstLoad = prefs.getBool("isFirstLoad");
//   if (isFirstLoad == null || isFirstLoad == true) {
//     await prefs.setBool("isFirstLoad", false);
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // _getOnboarding();
  await injector_container.init();
  final AppConfig configuredApp = AppConfig(
    envConfig: DevUrlConfig(),
    child: MyApp(
      isFirstLoad: isFirstLoad,
    ),
  );
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(configuredApp);
}

class DevUrlConfig implements EnvConfig {
  @override
  String apiUrl() => 'http://caramelseed-api-dev.eba-adznmjzz.us-east-2.elasticbeanstalk.com:3000';
}
