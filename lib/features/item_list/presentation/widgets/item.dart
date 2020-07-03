import 'package:flutter/material.dart';
import '../../../../core/widgets/card.dart';
import '../../domain/entities/item.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key key,
    @required this.itemToShow 
  }) : super(key: key);

  final Item itemToShow;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      cardContent: ListTile(
        isThreeLine: false,
        title: Text(
          itemToShow.name,
          style: Theme.of(context).textTheme.subtitle2.copyWith(color: Theme.of(context).primaryColor),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.chevron_right),
          color: Theme.of(context).primaryColor,
          iconSize: 40,
          onPressed: () {},
        ),
        subtitle: Text(
          itemToShow.description,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}