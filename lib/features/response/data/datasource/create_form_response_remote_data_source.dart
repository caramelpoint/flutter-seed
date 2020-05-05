import 'dart:convert';

import 'package:caramelseed/core/managers/token_manager.dart';
import 'package:caramelseed/features/response/data/model/form_response_model.dart';
import 'package:caramelseed/features/response/domain/entities/form_template.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/commons/common_endpoints.dart';
import '../../../../core/commons/common_http.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/error/exceptions.dart';

abstract class CreateFormResponseRemoteDataSource {
  /// Calls the endpoint configured to create a form response into the database
  ///
  /// Throws a [ServerException] for all errors code
  Future<FormResponseModel> create(FormTemplate formTemplate);
}

class CreateFormResponseRemoteDataSourceImpl implements CreateFormResponseRemoteDataSource {
  final http.Client client;
  final EnvConfig envConfig;
  final TokenManager tokenManager;

  static const String STATUS_FINISHED = 'finished';
  static const String STATUS_INPROGRESS = 'inProgress';

  CreateFormResponseRemoteDataSourceImpl({
    @required this.client,
    @required this.tokenManager,
    @required this.envConfig,
  });

  @override
  Future<FormResponseModel> create(FormTemplate formTemplate) async {
    final String url = '${envConfig.apiUrl()}${EndPointsCommon.FORM_RESPONSE_URL}';
    final FormResponseModel formResponseModel = FormResponseModel(
      formTemplateId: formTemplate.id,
      formTemplateName: formTemplate.name,
      agent: "formTemplate.agent",
      subject: "formTemplate.subject",
      status: STATUS_INPROGRESS, //optional
    );
    final String body = jsonEncode(formResponseModel.toJson());
    try {
      final http.Response httpResponse = await client.post(
        url,
        headers: HttpCommon.getAuthorizedHeaders(tokenManager.getToken()),
        body: body,
      );

      if (httpResponse.statusCode == 200) {
        final Map<String, dynamic> jsonFormResponseMap = jsonDecode(httpResponse.body) as Map<String, dynamic>;
        return FormResponseModel.fromJson(jsonFormResponseMap);
      } else {
        throw ServerException();
      }
    } catch (_) {
      throw ServerException();
    }
  }
}
