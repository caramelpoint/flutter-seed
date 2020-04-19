// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonResponse<T> _$CommonResponseFromJson<T>(Map<String, dynamic> json) {
  return CommonResponse<T>(
    data: (json['data'] as List)?.map(_Converter<T>().fromJson)?.toList(),
  );
}

Map<String, dynamic> _$CommonResponseToJson<T>(CommonResponse<T> instance) =>
    <String, dynamic>{
      'data': instance.data?.map(_Converter<T>().toJson)?.toList(),
    };
