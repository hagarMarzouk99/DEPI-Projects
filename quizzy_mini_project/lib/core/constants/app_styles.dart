import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  AppStyles._();

  static TextStyle _base({
    required double size,
    required FontWeight weight,
    double? height,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      height: height,
    );
  }

  
  static final headline = _base(size: 32, weight: FontWeight.w800);

  
  static final title = _base(size: 16, weight: FontWeight.w400);

  
  static final subtitle = _base(size: 18, weight: FontWeight.w600);

  
  static final body = _base(size: 12, weight: FontWeight.w400, height: 1.5);

  
  static final caption = _base(size: 10, weight: FontWeight.w600);

  
  static final badge = _base(size: 11, weight: FontWeight.w600);

  
  static final button = _base(size: 15, weight: FontWeight.w700);

  
  static final score = _base(size: 40, weight: FontWeight.w800);
}