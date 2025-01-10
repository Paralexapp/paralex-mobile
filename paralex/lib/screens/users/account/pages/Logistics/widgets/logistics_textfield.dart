import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';

class LogisticsTextfield extends StatelessWidget {
  const LogisticsTextfield(
      {super.key,
      this.minLines,
      this.padding,
      this.hintText,
      this.keyboardType,
      this.icon,
      this.controller,
      this.borderColor,
      this.suffixIcon,
      this.showPrefixIcon = false,
      this.showSuffixIcon = false,
      this.maxLines,
      this.prefix,
      this.suffix});
  final String? hintText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final Color? borderColor;
  final bool showPrefixIcon;
  final bool showSuffixIcon;
  final int? maxLines;
  final int? minLines;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      decoration: InputDecoration(
        contentPadding: padding,
        prefixIcon: prefix ??
            (showPrefixIcon == true
                ? Icon(
                    icon,
                    color: PaintColors.paralexpurple,
                  )
                : null),
        suffixIcon: suffix ??
            (showSuffixIcon == true
                ? Icon(
                    suffixIcon,
                    color: PaintColors.paralexpurple,
                  )
                : null),
        filled: true,
        fillColor: PaintColors.paralexVeryLightGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide:
              BorderSide(color: borderColor ?? PaintColors.paralexTransparent, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide:
              BorderSide(color: borderColor ?? PaintColors.paralexTransparent, width: 2),
        ),
        hintText: hintText,
        hintStyle: FontStyles.cancelTextStyle
            .copyWith(fontWeight: FontWeight.w500, color: PaintColors.bodyText1Color),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Required *';
        }
        return null;
      },
    );
  }
}

class LogisticsPhoneField extends StatelessWidget {
  const LogisticsPhoneField(
      {super.key,
      this.suffixWidget,
      this.hintText,
      this.onChanged,
      this.onCountryChanged,
      this.controller,
      this.validator});
  final Widget? suffixWidget;
  final String? hintText;
  final TextEditingController? controller;
  final void Function(PhoneNumber phoneNumber)? onChanged;
  final void Function(Country country)? onCountryChanged;
  final String? Function(PhoneNumber?)? validator;
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
        keyboardType: TextInputType.number,
        dropdownIconPosition: IconPosition.trailing,
        dropdownDecoration: BoxDecoration(),
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          filled: true,
          fillColor: PaintColors.paralexVeryLightGrey,
          suffixIcon: suffixWidget,
          hintText: hintText,
          hintStyle: FontStyles.cancelTextStyle
              .copyWith(fontWeight: FontWeight.w500, color: PaintColors.bodyText1Color),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: PaintColors.paralexTransparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: PaintColors.paralexTransparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: PaintColors.paralexTransparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: PaintColors.paralexTransparent),
          ),
        ),
        initialCountryCode: 'NG',
        onChanged: onChanged,
        onCountryChanged: onCountryChanged,
        validator: validator);
  }
}
