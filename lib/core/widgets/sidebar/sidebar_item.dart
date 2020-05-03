import 'package:flutter/material.dart';

import '../../config/size_config.dart';

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final GestureTapCallback onTap;

  const SidebarItem({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SizeConfig.init(context);
    return ListTile(
      title: Container(
        height: SizeConfig.safeBlockHorizontal * 15,
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: theme.colorScheme.primary,
            ),
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.safeBlockVertical * 1),
              child: Text(
                text,
                style: theme.textTheme.body1,
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
