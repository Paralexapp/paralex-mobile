import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class FontStyles {
  static final TextStyle smallCapsIntro = GoogleFonts.plusJakartaSans(
      fontSize: 12, letterSpacing: 6.0, color: Colors.white);
  static final TextStyle headingText = GoogleFonts.plusJakartaSans(
      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static final TextStyle contentText = GoogleFonts.plusJakartaSans(
      fontSize: 12, color: Color(0xFF4A4A68));
  static final TextStyle hintStyle = GoogleFonts.workSans(
    fontSize: 16,color: Color(0xFF8C8CA1));
}
