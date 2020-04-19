// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return ItemModel(
    itemId: json['_id'] as String,
    name: json['name'] as String,
    createdAt: json['createdAt'] as String,
    description: json['description'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('updatedAt', instance.updatedAt);
  writeNotNull('_id', instance.itemId);
  return val;
}
