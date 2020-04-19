import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/commons/common_state.dart';
import '../../entities/item.dart';

abstract class GetAllItemsState extends Equatable implements CommonState {
  const GetAllItemsState();
}

class InitialState extends GetAllItemsState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'InitialState { items: [] }';
}

class GettingItems extends GetAllItemsState implements LoadingState {
  const GettingItems({@required this.msg});
  final String msg;

  @override
  List<Object> get props => [msg];

  @override
  String toString() => 'GettingItems';

  @override
  String get message => msg;
}

class ItemsLoaded extends GetAllItemsState {
  final List<Item> items;

  const ItemsLoaded({@required this.items});

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'ItemsLoaded { itemList length: ${items.length} }';
}

class ErrorGettingItems extends GetAllItemsState implements ErrorState {
  final String msg;

  const ErrorGettingItems({this.msg});

  @override
  List<Object> get props => [message];

  @override
  String get message => msg;

  @override
  String toString() => 'ErrorGettingItems { message: $message }';
}
