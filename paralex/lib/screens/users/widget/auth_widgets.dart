import 'package:flutter/material.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';

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
            color: PaintColors.paralaxpurple, fontWeight: FontWeight.w900),
        // style: style,
      ),
    );
  }
}
