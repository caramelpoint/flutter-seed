import 'package:equatable/equatable.dart';

abstract class GetAllItemsEvent extends Equatable {
  const GetAllItemsEvent();

  @override
  List<Object> get props => <List<Object>>[];
}

class GetAllItems extends GetAllItemsEvent {
  const GetAllItems();

  @override
  String toString() {
    return 'GetAllItems';
  }
}
