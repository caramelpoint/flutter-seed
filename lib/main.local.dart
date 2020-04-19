import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/simple_bloc_delegate.dart';
import 'core/config/app_config.dart';
import 'core/config/env_config.dart';
import 'injection_container.dart' as injector;
import 'main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector.init();
  final AppConfig configuredApp = AppConfig(
    envConfig: LocalUrlConfig(),
    child: MyApp(),
  );
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(configuredApp);
}

class LocalUrlConfig implements EnvConfig {
  @override
  String apiUrl() => 'http://localhost:3000';
}
