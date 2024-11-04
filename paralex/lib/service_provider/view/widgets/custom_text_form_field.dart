import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextStyle? textStyle;
  final InputDecoration? decoration;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool readonly;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final FormFieldValidator<String>? validator;
  final VoidCallback? ontap;
  final bool? enabled;

  CustomTextFormField({
    Key? key,
    this.hintText = '',
    this.labelText = '',
    this.textStyle,
    this.decoration,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.readonly = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.validator,
    this.ontap,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: textStyle ?? TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      readOnly: readonly,
      validator: validator,
      onTap: ontap,
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decoration ??
          InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: (enabled ?? true) ? Color(0xFFECF1F4):Color(0x70ECF1F4),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Color(0xFFECF1F4)),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Color(0x10ECF1F4),),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF4C1044), width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: suffixIcon != null
                ? InkWell(
              onTap: onSuffixTap,
              child: suffixIcon,
            )
                : null,
          ),
    );
  }
}
