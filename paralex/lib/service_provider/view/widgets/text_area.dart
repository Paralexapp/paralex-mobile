import 'package:flutter/material.dart';

class ReusableTextArea extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  const ReusableTextArea({
    super.key,
    required this.labelText,
    this.hintText,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 5,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
