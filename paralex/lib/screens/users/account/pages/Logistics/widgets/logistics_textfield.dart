import 'package:flutter/material.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';

class LogisticsTextfield extends StatelessWidget {
  const LogisticsTextfield({super.key, this.hintText, this.icon, this.controller, this.borderColor, this.suffixIcon,this.showPrefixIcon = false, this.showSuffixIcon = false, this.maxLines});
  final String? hintText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final Color? borderColor;
  final bool showPrefixIcon;
  final bool showSuffixIcon;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
    keyboardType: TextInputType.text,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        prefixIcon: showPrefixIcon == true ? Icon(icon, color: PaintColors.paralexpurple,) : null,
        suffixIcon: showSuffixIcon == true ? Icon(suffixIcon, color: PaintColors.paralexpurple,) : null,
        filled: true,
        fillColor: PaintColors.paralexVeryLightGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: borderColor ?? PaintColors.paralexTransparent, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: borderColor ?? PaintColors.paralexTransparent, width: 2),
        ),
        hintText: hintText,
        hintStyle: FontStyles.cancelTextStyle.copyWith(fontWeight: FontWeight.w500, color: PaintColors.bodyText1Color),
      ),
    );
  }
}
