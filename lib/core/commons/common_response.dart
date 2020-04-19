import 'package:json_annotation/json_annotation.dart';

import '../../features/item_list/data/model/item_model.dart';

part 'common_response.g.dart';

@JsonSerializable()
class CommonResponse<T> {
  @JsonKey(name: 'data')
  @_Converter()
  final List<T> data;

  CommonResponse({this.data});

  factory CommonResponse.fromJson(Map<String, dynamic> json) => _$CommonResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic>) {
      return ItemModel.fromJson(json) as T;
    }
    return json as T;
  }

  @override
  Object toJson(T object) {
    return object;
  }
}
