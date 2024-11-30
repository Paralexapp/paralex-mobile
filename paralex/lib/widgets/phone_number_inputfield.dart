import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneNumberInputField extends StatelessWidget {
  final String hintText;
  final void Function(PhoneNumber)? onChanged;
  const PhoneNumberInputField({super.key, required this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xFFECF1F4),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),
      initialCountryCode: 'NG',
      onChanged: onChanged,
    );
  }
}
