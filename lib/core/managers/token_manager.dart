import 'package:caramelseed/core/error/exceptions.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String SESSION_TOKEN = 'SESSION_TOKEN';

abstract class TokenManager {
  Future<void> saveToken(Map<String, String> headers);

  String getToken();
}

class TokenManagerImpl implements TokenManager {
  final SharedPreferences sharedPreferences;

  TokenManagerImpl({
    @required this.sharedPreferences,
  });

  @override
  String getToken() {
    final String token = sharedPreferences.getString(SESSION_TOKEN);
    if (token != null) {
      return token;
    } else {
      throw GetTokenException();
    }
  }

  @override
  Future<void> saveToken(Map<String, String> headers) async {
    if (headers['authorization'] != null) {
      await sharedPreferences.setString(SESSION_TOKEN, headers['authorization']);
    } else {
      throw SaveTokenException();
    }
  }
}
