import 'package:flutter/material.dart';

import '../config/size_config.dart';

class Button extends StatelessWidget {
  const Button({
    Key key,
    @required VoidCallback onPressed,
    String text,
    Color backgroundColor,
    Color textColor,
  })  : _onPressed = onPressed,
        _text = text ?? 'OK',
        _backgroundColor = backgroundColor ?? Colors.white,
        _textColor = textColor ?? Colors.black,
        super(key: key);

  final VoidCallback _onPressed;
  final String _text;
  final Color _backgroundColor;
  final Color _textColor;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SizedBox(
      height: 45.0,
      width: SizeConfig.safeBlockHorizontal * 50,
      child: RaisedButton(
        key: Key(_text),
        color: _backgroundColor,
        disabledColor: _backgroundColor.withOpacity(0.90),
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        onPressed: _onPressed,
        child: Text(
          _text.toUpperCase(),
          style: Theme.of(context).textTheme.button.copyWith(color: _textColor),
        ),
      ),
    );
  }
}
