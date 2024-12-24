import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Define primary, secondary, and other colors
  static const Color primary = Color(0xff000000); 
  static const Color background = Color(0xffECF6FF); 
  static const Color accent = Color(0xffE195AB); 
  static const Color textPrimary = Color(0xFF212121); 
  static const Color textSecondary = Color(0xffFFEB6B); 

  // Define fonts using Google Fonts

  static final TextStyle greetingStyle = GoogleFonts.playfairDisplay(
    fontStyle: FontStyle.italic,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: textPrimary,
  );
  static final TextStyle greetingStyleBold = GoogleFonts.playfairDisplay(
    fontStyle: FontStyle.italic,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

static final TextStyle greetingStyleNormal = GoogleFonts.playfairDisplay(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );
  static final TextStyle greetingStyleNormalBold = GoogleFonts.playfairDisplay(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );


  static final TextStyle screenTitleStyle = GoogleFonts.playfairDisplay(
    fontStyle: FontStyle.italic,
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  static final TextStyle titleStyle = GoogleFonts.beVietnamPro(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static final TextStyle titleStyleNormal = GoogleFonts.beVietnamPro(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );


  static final TextStyle bodyStyle = GoogleFonts.beVietnamPro(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );
  static final TextStyle bodyStyleBold = GoogleFonts.beVietnamPro(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );
  static final TextStyle defaultStyleTitle = GoogleFonts.beVietnamPro(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );
  static final TextStyle defaultStyle = GoogleFonts.beVietnamPro(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );
  

  static final TextStyle bodyStyleBoldColored = GoogleFonts.beVietnamPro(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.red,
  );
  static final TextStyle captionStyle = GoogleFonts.beVietnamPro(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static final TextStyle captionStyleBold = GoogleFonts.beVietnamPro(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static final TextStyle captionStyleBlack = GoogleFonts.beVietnamPro(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}