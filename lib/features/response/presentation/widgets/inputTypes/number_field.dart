import 'package:caramelseed/core/config/size_config.dart';
import 'package:flutter/material.dart';

import '../step_content.dart';

class NumberField extends StatefulWidget {
  const NumberField({
    Key key,
    this.inputController,
  }) : super(key: key);

  final InputController inputController;

  @override
  _NumberFieldState createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
  int _number = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SizeConfig.init(context);
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
            child: FloatingActionButton(
              elevation: 4,
              mini: true,
              onPressed: () {
                _decrement();
              },
              child: Icon(
                const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          Text(
            // "${widget.inputController.currentResponseValue}",
            "$_number",
            style: Theme.of(context).textTheme.headline.copyWith(color: theme.colorScheme.primaryVariant),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
            child: FloatingActionButton(
              elevation: 4,
              mini: true,
              onPressed: () {
                _increment();
              },
              backgroundColor: Colors.white,
              child: Icon(Icons.add, color: theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  // void _changevalue(value) {
  //   widget.inputController.currentResponseValue = value as int;
  //   _udpateState();
  // }

  void _increment() {
    widget.inputController.currentResponseValue = _parseCurrentValue() + 1;
    _udpateState();
  }

  void _decrement() {
    widget.inputController.currentResponseValue = _parseCurrentValue() - 1;
    _udpateState();
  }

  void _udpateState() {
    setState(() {
      _number = widget.inputController.currentResponseValue as int;
    });
  }

  int _parseCurrentValue() {
    int currentValue = 0;
    if (widget.inputController.currentResponseValue is int) {
      currentValue = widget.inputController.currentResponseValue as int;
    }
    return currentValue;
  }
}
