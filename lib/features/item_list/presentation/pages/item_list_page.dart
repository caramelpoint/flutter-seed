import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/size_config.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/get_all_items/bloc.dart';
import '../widgets/item_list.dart';

class ItemListPage extends StatelessWidget {
  const ItemListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.cardColor,
        iconTheme: IconThemeData(
          color: theme.colorScheme.secondary,
        ),
      ),
      drawer: Drawer(
        child: Container()
      ),
      body: Center(
        child: BlocProvider<GetAllItemsBloc>(
          create: (BuildContext context) => injector<GetAllItemsBloc>()..add(const GetAllItems()),
          child: const ItemList(),
        ),
      ),
    );
  }
}
