import 'package:flutter/material.dart';

import '../config/size_config.dart';

typedef ValidatorFn = String Function(String);

class InputField extends StatefulWidget {
  const InputField({
    Key key,
    this.fieldName,
    this.icon,
    this.fieldLabel,
    this.textInputType,
    this.activeColor,
    this.hidden,
    this.controller,
    this.validatorFn,
  }) : super(key: key);

  final String fieldName;
  final IconData icon;
  final String fieldLabel;
  final TextInputType textInputType;
  final Color activeColor;
  final bool hidden;
  final TextEditingController controller;
  final ValidatorFn validatorFn;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SizeConfig.init(context);
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
      child: SizedBox(
        width: SizeConfig.safeBlockHorizontal * 85,
        child: TextFormField(
          controller: widget.controller,
          key: Key(widget.fieldName),
          maxLines: 1,
          obscureText: widget.hidden,
          keyboardType: widget.textInputType,
          validator: (String value) {
            if (widget.controller.text.isNotEmpty) {
              final String validationResult = widget.validatorFn(value);
              return validationResult;
            }
            return null;
          },
          keyboardAppearance: Brightness.dark,
          // autofocus: false,
          autovalidate: true,
          autocorrect: false,
          decoration: InputDecoration(
            labelText: widget.fieldLabel,
            filled: true,
            fillColor: Colors.white,
            labelStyle: TextStyle(
              color: theme.cursorColor,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.cursorColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.activeColor ?? theme.primaryColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.activeColor ?? theme.primaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: theme.primaryColor,
              ),
            ),
            errorStyle: theme.textTheme.caption.copyWith(
              color: theme.primaryColor,
            ),
            prefixIcon: Icon(
              widget.icon,
              color: widget.activeColor ?? theme.cursorColor,
            ),
          ),
        ),
      ),
    );
  }
}
