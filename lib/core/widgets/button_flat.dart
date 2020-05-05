import 'package:flutter/material.dart';

import '../config/size_config.dart';

class ButtonFlat extends StatelessWidget {
  const ButtonFlat({
    Key key,
    VoidCallback onPressed,
    String text,
    Color splahsColor,
    Color textColor,
  })  : _onPressed = onPressed,
        _text = text,
        _splahsColor = splahsColor ?? Colors.white,
        _textColor = textColor ?? Colors.black,
        super(key: key);

  final VoidCallback _onPressed;
  final String _text;
  final Color _splahsColor;
  final Color _textColor;

  @override
  Widget build(BuildContext context) {
    debugPrint('Building $this');
    final ThemeData theme = Theme.of(context);
    SizeConfig.init(context);
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.safeBlockHorizontal,
        right: SizeConfig.safeBlockHorizontal,
        top: SizeConfig.safeBlockVertical,
      ),
      child: FlatButton(
        key: Key(_text),
        onPressed: _onPressed,
        splashColor: _splahsColor,
        padding: const EdgeInsets.all(0.0),
        child: Text(
          _text,
          style: theme.textTheme.headline.copyWith(color: _textColor),
        ),
      ),
    );
  }
}
