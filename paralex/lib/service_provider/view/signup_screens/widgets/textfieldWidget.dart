import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final String hintText;
  final TextStyle? textStyle;
  final InputDecoration? decoration;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;

  TextfieldWidget({
    Key? key,
    this.hintText = '',
    this.textStyle,
    this.decoration,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: textStyle ?? TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: decoration ??
          InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Color(0xFFECF1F4),
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF4C1044), width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
    );
  }
}


