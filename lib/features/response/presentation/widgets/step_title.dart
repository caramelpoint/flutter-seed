import 'package:flutter/material.dart';

import '../../../../core/config/size_config.dart';

class StepTitle extends StatelessWidget {
  final String titleText;
  const StepTitle(this.titleText);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SizeConfig.init(context);
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 3),
        width: SizeConfig.safeBlockHorizontal * 65,
        child: Center(
          child: Text(
            titleText,
            style: theme.textTheme.subtitle.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
