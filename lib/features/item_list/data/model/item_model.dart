import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/item.dart';

part 'item_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ItemModel extends Item {
  const ItemModel({
    this.itemId,
    String name,
    String createdAt,
    String description,
    String updatedAt,
  }) : super(
    id: itemId,
    name: name,
    description: description,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  @JsonKey(name: '_id')
  final String itemId;

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
