import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/simple_bloc_delegate.dart';
import 'core/config/app_config.dart';
import 'core/config/env_config.dart';
import 'injection_container.dart' as injector_container;
import 'main.dart';

bool isFirstLoad = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
