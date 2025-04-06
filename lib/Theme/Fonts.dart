import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jewellery_management/Theme/Colors.dart';

class AppTextStyles {
  static TextStyle heading = _interStyle(24.r, FontWeight.bold, textcolor);
  static TextStyle subHeading = _interStyle(20.r, FontWeight.w600, textcolor);
  static TextStyle body = _interStyle(16.r, FontWeight.normal, textcolor);
  static TextStyle small = _interStyle(12.r, FontWeight.normal, Colors.grey);
  static TextStyle error = _interStyle(14.r, FontWeight.bold, Colors.red);
  static TextStyle success = _interStyle(14.r, FontWeight.bold, Colors.green);

  static TextStyle _interStyle(double size, FontWeight weight, Color color) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: size.r,
        fontWeight: weight,
        height: 1.4.r,
        color: color,
      ),
    );
  }

  static TextStyle _luckiestGuyStyle(
      double size, FontWeight weight, Color color) {
    return GoogleFonts.luckiestGuy(
      textStyle: TextStyle(
        fontSize: size.r,
        fontWeight: weight,
        height: 1.4.r,
        color: color,
      ),
    );
  }

  static TextStyle custom({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    Color color = Colors.black,
    double height = 1.4,
    TextDecoration decoration = TextDecoration.none,
    double letterSpacing = 0,
    bool useLuckiestGuy = false,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize.r,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: color,
        height: height.r,
        decoration: decoration,
        letterSpacing: letterSpacing.r,
      ),
    );
  }
}

extension TextStyleModifiers on TextStyle {
  TextStyle withColor(Color customColor) => copyWith(color: customColor);
  TextStyle withSize(double customSize) => copyWith(fontSize: customSize.r);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get strikeThrough =>
      copyWith(decoration: TextDecoration.lineThrough);
}
