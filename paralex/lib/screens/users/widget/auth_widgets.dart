import 'package:flutter/material.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final String style;
  const TextWidget({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: FontStyles.headingText.copyWith(
            color: PaintColors.paralexpurple, fontWeight: FontWeight.w900),
        // style: style,
      ),
    );
  }
}
