import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/commons/common_messages.dart';
import '../../../../../core/error/failures.dart';
import '../../entities/item.dart';
import '../../repositories/item_repository.dart';
import 'bloc.dart';

class GetAllItemsBloc extends Bloc<GetAllItemsEvent, GetAllItemsState> {
  ItemRepository repository;

  GetAllItemsBloc({@required this.repository});

  @override
  GetAllItemsState get initialState => InitialState();

  @override
  Stream<GetAllItemsState> mapEventToState(
    GetAllItemsEvent event,
  ) async* {
    if (event is GetAllItems) {
      yield* _mapGetAllItemsToState();
    }
  }

  Stream<GetAllItemsState> _mapGetAllItemsToState({
    String email,
    String password,
  }) async* {
    yield const GettingItems(msg: CommonMessage.GETTING_ITEMS);
    final Either<Failure, List<Item>> failureOrUser = await repository.getAll();
    yield failureOrUser.fold(
      (failure) => ErrorGettingItems(msg: _mapFailureToMessage(failure)),
      (itemsList) {
        return ItemsLoaded(items: itemsList);
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NoConnectionFailure:
        return CommonMessage.NO_CONNECTION_FAILURE_MESSAGE;
      case GetAllItemsFailure:
        return CommonMessage.GETTING_ITEMS_ERROR;
      default:
        return 'Unexpected error';
    }
  }
}
