import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;

  const Item({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object> get props => [id, name, description, createdAt, updatedAt];
}