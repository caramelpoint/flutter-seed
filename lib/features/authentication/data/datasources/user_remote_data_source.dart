// import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/config/env_config.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/managers/token_manager.dart';
import '../../domain/entities/user.dart';
// import '../model/user_model.dart';

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
    await Future.delayed(const Duration(seconds: 3));
    return Future.value(
        const User(email: 'MockUser@test.com', name: 'mock', lastname: 'lastname', username: 'mockuser'));
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
  }

  // Map<String, String> _getUserMap({String email, String password}) {
  //   final Map<String, String> userMap = <String, String>{};
  //   userMap['email'] = email;
  //   userMap['password'] = password;
  //   return userMap;
  // }

  // User _parseUser(String userResponse) {
  //   final Map<String, dynamic> userMap = jsonDecode(userResponse) as Map<String, dynamic>;
  //   return UserModel.fromJson(userMap);
  // }
}
