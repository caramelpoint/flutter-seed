import 'dart:convert';

import 'package:caramelseed/features/item_list/data/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/authorization/token_manager.dart';
import '../../../../core/commons/common_endpoints.dart';
import '../../../../core/commons/common_http.dart';
import '../../../../core/commons/common_response.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/item.dart';

//packages to mock response
import '../../../../core/util/fixture_reader.dart';


abstract class ItemRemoteDataSource {
  Future<List<Item>> getAll();
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final http.Client client;
  final EnvConfig envConfig;
  final TokenManager tokenManager;
  final FixtureReader fixtureReader = FixtureReader();

  ItemRemoteDataSourceImpl({
    @required this.client,
    @required this.tokenManager,
    @required this.envConfig,
  });

  @override
  Future<List<Item>> getAll() async {
  //   final String url = '${envConfig.apiUrl()}${EndPointsCommon.LIST_URL}';
  //   try {
  //     final http.Response response = await client.get(
  //       url,
  //       headers: HttpCommon.getAuthorizedHeaders(tokenManager.getToken()),
  //     );
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> map = jsonDecode(response.body) as Map<String, dynamic>;
  //       return CommonResponse<Item>.fromJson(map).data;
  //     } else {
  //       throw ServerException();
  //     }
  //   } catch (_) {
  //     throw ServerException();
  //   }
  // }
    final String itemsResponse = await fixtureReader.fixture('get_all_items_mock.json');
    final CommonResponse<ItemModel> commonResponse = CommonResponse<ItemModel>.fromJson(jsonDecode(itemsResponse) as Map<String, dynamic>);
    
    return commonResponse.data;
  }
}