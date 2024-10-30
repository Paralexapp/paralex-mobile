import 'package:flutter/material.dart';
import 'package:paralax/reusables/paints.dart';

class PinkButton{
  static final backButton = Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFFFEAF5),
      ),
      child: Icon(Icons.arrow_back_ios_new_sharp, size: 12,color: PaintColors.paralaxpurple,),
    );
}