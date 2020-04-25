import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/authentication/domain/usecases/user_session/bloc.dart';
import '../../config/size_config.dart';
import '../spinner.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSessionBloc, UserSessionState>(
      builder: (context, state) {
        if (state is Authenticated) {
          final ThemeData theme = Theme.of(context);
          SizeConfig.init(context);
          return DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: SizeConfig.safeBlockHorizontal * 20,
                    color: theme.primaryColor,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(state.user.getUserFullName(), style: theme.textTheme.body1),
                        Text(
                          state.user.email,
                          style: theme.textTheme.overline.copyWith(color: theme.colorScheme.secondaryVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 20),
          child: const Spinner(),
        );
      },
    );
  }
}
