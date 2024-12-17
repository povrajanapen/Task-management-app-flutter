import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Define primary, secondary, and other colors
  static const Color primary = Color(0xff000000); 
  static const Color background = Color(0xffECF6FF); 
  static const Color accent = Color(0xff80C4E9); 
  static const Color textPrimary = Color(0xFF212121); 
  static const Color textSecondary = Color(0xff000B58); 

  // Define fonts using Google Fonts

  static final TextStyle greetingStyle = GoogleFonts.fredoka(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static final TextStyle titleStyle = GoogleFonts.fredoka(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static final TextStyle bodyStyle = GoogleFonts.fredoka(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );

  static final TextStyle buttonStyle = GoogleFonts.fredoka(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final TextStyle captionStyle = GoogleFonts.fredoka(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );
}