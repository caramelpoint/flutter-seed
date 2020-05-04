import 'package:flutter_data/flutter_data.dart';

import '../../injection_container.dart';
import '../config/env_config.dart';
import '../managers/token_manager.dart';

mixin BaseEntityAdapter<T extends DataSupportMixin<T>> on Repository<T> {
  final TokenManager tokenManager = injector<TokenManager>();
  final EnvConfig envConfig = injector<EnvConfig>();

  @override
  String get baseUrl => envConfig.apiUrl();

  @override
  Map<String, dynamic> get headers {
    final token = tokenManager.getToken();
    return super.headers..addAll({'Authorization': token});
  }
}
