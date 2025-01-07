import 'package:flutter/material.dart';

import '../../../reusables/paints.dart';
class BlackButton extends StatelessWidget {
  final Color containerColor;
  final Color iconColor;

  const BlackButton({
    super.key,
    this.containerColor = const Color(0xFFFFEAF5),
    this.iconColor = PaintColors.paralexpurple,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: containerColor,
      ),
      child: Icon(
        Icons.arrow_back_ios_new_sharp,
        size: 12,
        color: iconColor,
      ),
    );
  }
}