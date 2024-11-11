import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextStyle? textStyle;
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

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.labelText = '',
    this.textStyle,
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
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: controller,
          style: textStyle ?? const TextStyle(color: Colors.black),
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          readOnly: readonly,
          validator: validator,
          onTap: ontap,
          enabled: enabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: (enabled ?? true)
                ? const Color(0xFFECF1F4)
                : const Color(0x70ECF1F4),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
            suffixIcon: suffixIcon != null
                ? InkWell(
                    onTap: onSuffixTap,
                    child: suffixIcon,
                  )
                : null,
          ),
        ),
        // Placeholder text overlay
        // if ((controller?.text.isEmpty ?? true))
        //   Positioned(
        //     left: 20,
        //     top: 12,
        //     child: Text(
        //       hintText,
        //       style: TextStyle(color: Color(0x608C8CA1), fontSize: 16),
        //     ),
        //   ),
      ],
    );
  }
}
