import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/size_config.dart';
import '../../../../core/util/snackbar.dart';
import '../../domain/usecases/get_all_items/bloc.dart';
import './item.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocListener<GetAllItemsBloc, GetAllItemsState>(
      listener: (BuildContext context, GetAllItemsState state) {
        if (state is ErrorGettingItems) {
          SnackbarUtil.showSnakbar(
            context: context,
            text: state.message,
            type: SnackbarUtil.ERROR,
          );
        }
        if (state is GettingItems) {
          SnackbarUtil.showSnakbar(
            duration: 20,
            context: context,
            text: state.message,
          );
        }
        if (state is ItemsLoaded) {
          SnackbarUtil.hideCurrentSnackBar(context);
        }
      },
      child: BlocBuilder<GetAllItemsBloc, GetAllItemsState>(
        builder: (BuildContext context, GetAllItemsState state) {
          if (state is ItemsLoaded) {
            return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text("Items", style: Theme.of(context).textTheme.headline6)),
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemWidget(itemToShow: state.items[index]);
                            }),
                      ),
                    ]));
          }
          //TODO: Show empty list message
          return Container();
        },
      ),
    );
  }
}
