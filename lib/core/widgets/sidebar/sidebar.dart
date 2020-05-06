import 'package:caramelseed/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/authentication/domain/usecases/user_session/bloc.dart';
import 'custom_header.dart';
import 'sidebar_item.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const UserInfoHeader(),
        SidebarItem(
          icon: Icons.exit_to_app,
          text: 'Logout',
          onTap: () {
            BlocProvider.of<UserSessionBloc>(context).add(LoggedOut());
            Navigator.of(context).pushReplacementNamed(LOGIN_ROUTE);
          },
        )
      ],
    ));
  }
}
