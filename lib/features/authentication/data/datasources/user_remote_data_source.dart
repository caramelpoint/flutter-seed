import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/authorization/token_manager.dart';
import '../../../../core/commons/common_endpoints.dart';
import '../../../../core/commons/common_http.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user.dart';
import '../model/user_model.dart';

const String SESSION_TOKEN = 'SESSION_TOKEN';

abstract class UserRemoteDataSource {
  /// Calls the endpoint configured to login an user
  ///
  /// Throws a [ServerException] for all errors code
  Future<User> login({String email, String password});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final EnvConfig envConfig;
  final TokenManager tokenManager;

  UserRemoteDataSourceImpl({
    @required this.client,
    @required this.tokenManager,
    @required this.envConfig,
  });

  @override
  Future<User> login({String email, String password}) async {
    // final String body = jsonEncode(_getUserMap(email: email, password: password));
    // final http.Response response = await client.post(
    //   '${envConfig.apiUrl()}${EndPointsCommon.LOGIN_URL}',
    //   headers: HttpCommon.getHeaders(),
    //   body: body,
    // );
    // try {
    //   if (response.statusCode == 200) {
    //     await tokenManager.saveToken(response.headers);
    //     return _parseUser(response.body);
    //   } else {
    //     throw ServerException();
    //   }
    // } catch (_) {
    //   throw ServerException();
    // }
    return User(name: 'mock_user', email: email);
  }

  Map<String, String> _getUserMap({String email, String password}) {
    final Map<String, String> userMap = <String, String>{};
    userMap['email'] = email;
    userMap['password'] = password;
    return userMap;
  }

  User _parseUser(String userResponse) {
    final Map<String, dynamic> userMap = jsonDecode(userResponse) as Map<String, dynamic>;
    return UserModel.fromJson(userMap);
  }
}
