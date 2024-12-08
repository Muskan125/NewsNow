import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color hotRed = Color(0xFFE53935);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color(0xFFBDBDBD);
}

class AppTextStyle {
  static TextStyle title = GoogleFonts.roboto(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static TextStyle subtitle = GoogleFonts.merriweather(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  static TextStyle body = GoogleFonts.lora(
    fontSize: 14,
    color: AppColors.black,
  );

  static TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}
