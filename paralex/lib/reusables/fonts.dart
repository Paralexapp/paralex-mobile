import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:paralex/reusables/paints.dart';

class FontStyles {
  static final TextStyle smallCapsIntro = GoogleFonts.plusJakartaSans(
      fontSize: 12, letterSpacing: 6.0, color: Colors.white);
  static final TextStyle headingText = GoogleFonts.plusJakartaSans(
      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static final TextStyle contentText =
      GoogleFonts.plusJakartaSans(fontSize: 12, color: const Color(0xFF4A4A68));
  static final TextStyle hintStyle =
      GoogleFonts.workSans(fontSize: 16, color: const Color(0xFF8C8CA1));

  static final TextStyle cancelTextStyle =  GoogleFonts.workSans(
      fontSize: 16,
      color: PaintColors.cancelTextColor,
  fontWeight: FontWeight.w400);
  static final TextStyle bodyText1 =  TextStyle(
      fontSize: 18,
      color: PaintColors.bodyText1Color,
      fontWeight: FontWeight.w700);
}
