import 'dart:convert';

import 'package:caramelseed/core/commons/common_endpoints.dart';
import 'package:caramelseed/core/commons/common_http.dart';
import 'package:caramelseed/core/error/exceptions.dart';
import 'package:caramelseed/core/managers/token_manager.dart';
import 'package:caramelseed/features/response/data/model/response_model.dart';
import 'package:caramelseed/features/response/domain/entities/response.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/config/env_config.dart';

abstract class ResponseRemoteDataSource {
  /// Calls the endpoint configured to save the response into the database
  ///
  /// Throws a [ServerException] for all errors code
  Future<Response> saveResponse(Response response);
}

class ResponseRemoteDataSourceImp implements ResponseRemoteDataSource {
  final http.Client client;
  final EnvConfig envConfig;
  final TokenManager tokenManager;

  ResponseRemoteDataSourceImp({
    @required this.client,
    @required this.tokenManager,
    @required this.envConfig,
  });

  @override
  Future<ResponseModel> saveResponse(Response response) async {
    final String url = '${envConfig.apiUrl()}${EndPointsCommon.RESPONSE}';
    final String body = jsonEncode(ResponseModel.fromEntity(response).toJson());
    try {
      final http.Response httpResponse = await client.post(
        url,
        headers: HttpCommon.getAuthorizedHeaders(tokenManager.getToken()),
        body: body.toString(),
      );

      if (httpResponse.statusCode == 200) {
        final Map<String, dynamic> jsonResponseMap = jsonDecode(httpResponse.body) as Map<String, dynamic>;
        return ResponseModel.fromJson(jsonResponseMap);
      } else {
        throw ServerException();
      }
    } catch (_) {
      throw ServerException();
    }
  }
}
