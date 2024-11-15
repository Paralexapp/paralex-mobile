import 'package:flutter/material.dart';
import 'package:paralex/reusables/paints.dart';

class PinkButton {
  static final backButton = Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: const Color(0xFFFFEAF5),
    ),
    child: const Icon(
      Icons.arrow_back_ios_new_sharp,
      size: 12,
      color: PaintColors.paralexpurple,
    ),
  );
}
