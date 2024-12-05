import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldWidget extends StatelessWidget {
  final String hintText;
  final TextStyle? textStyle;
  final InputDecoration? decoration;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;
  final Color? fillColor;
  final bool readOnly;

  const TextfieldWidget(
      {super.key,
      this.hintText = '',
      this.textStyle,
      this.decoration,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.onChanged,
      this.validator,
      this.controller,
      this.formatters,
      this.fillColor,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: controller,
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return 'Required *';
              }
              return null;
            },
        readOnly: readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: textStyle ?? const TextStyle(color: Colors.black),
        inputFormatters: formatters,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: decoration ??
            InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: fillColor ?? const Color(0xFFECF1F4),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF4C1044), width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
      ),
    );
  }
}
