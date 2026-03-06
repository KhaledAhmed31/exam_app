import 'package:flutter/material.dart';

class FontStyleManager {
  FontStyleManager._();
  static const String fontFamilyRoboto = "Roboto";
  static const String fontFamilyInter = "Inter";

  // roboto ===================================
  static TextStyle _robotoStyle({
    Color? color,
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
  }) => TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    height: height,
    fontFamily: fontFamilyRoboto,
  );

 static TextStyle robotoRegular({
    Color? color,
    required double fontSize,
    double? height,
  }) => _robotoStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w400,
    color: color,
    height: height,
  );

 static TextStyle robotoMedium({
   Color? color,
    required double fontSize,
    double? height,
  }) => _robotoStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    color: color,
    height: height,
  );

 static TextStyle robotoBold({
     Color? color,
    required double fontSize,
    double? height,
  }) => _robotoStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w700,
    color: color,
    height: height,
  );

  // inter ===================================
  static TextStyle _interStyle({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
  }) => TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    height: height,
    fontFamily: fontFamilyInter,
  );

 
 static TextStyle interRegular({
    required Color color,
    required double fontSize,
    double? height,
  }) => _interStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w400,
    color: color,
    height: height,
  );

 static TextStyle interMedium({
    required Color color,
    required double fontSize,
    double? height,
  }) => _interStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    color: color,
    height: height,
  );

 static TextStyle interBold({
    required Color color,
    required double fontSize,
    double? height,
  }) => _interStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w700,
    color: color,
    height: height,
  );
}
