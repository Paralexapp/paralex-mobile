import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextStyle? textStyle;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool readonly;
  final Widget? suffixIcon;
  final Widget? prefix;
  final VoidCallback? onSuffixTap;
  final FormFieldValidator<String>? validator;
  final VoidCallback? ontap;
  final bool? enabled;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxline;
  final Color? fillColor;
  final List <TextInputFormatter>? inputFormatter;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.textStyle,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.readonly = false,
    this.suffixIcon,
    this.prefix,
    this.onSuffixTap,
    this.validator,
    this.ontap,
    this.enabled,
    this.contentPadding,
    this.maxline,
    this.fillColor,
    this.inputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: textStyle ?? TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      readOnly: readonly,
      onTap: ontap,
      inputFormatters: inputFormatter,
      enabled: enabled,
      maxLines: maxline ?? 1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: fillColor ?? Color(0x70ECF1F4) ,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Color(0xFFECF1F4)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Color(0x10ECF1F4)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF4C1044), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefix,
      ),
    );
  }
}
