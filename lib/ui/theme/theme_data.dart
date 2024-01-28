import 'package:flutter/material.dart';

// ignore_for_file: annotate_overrides

const String arabicFontFamily = "Baloo";
const String englishFontFamily = "Ubuntu";

// This can be used to specify colors and themes of the app
abstract class AppThemeData {
  Color get bottomSheetTextColor;
  Color get bottomSheetTitleColor;
  Color get bottomSheetBackgroundColor;
  Color get bottomSheetSliderColor;
  Color get bottomSheetIconColor1;
  Color get bottomSheetIconColor2;
}

class LightThemeData extends AppThemeData {
  get bottomSheetTextColor => Colors.black;
  get bottomSheetTitleColor => Colors.black;
  get bottomSheetBackgroundColor => Color(0xFFF0F6E8);
  get bottomSheetSliderColor => Colors.grey;
  get bottomSheetIconColor1 => Colors.black;
  get bottomSheetIconColor2 => Colors.green;
}

class DarkThemeData extends AppThemeData {
  get bottomSheetTextColor => Colors.white;
  get bottomSheetTitleColor => Colors.white;
  get bottomSheetBackgroundColor => const Color(0xFF00151A);
  get bottomSheetSliderColor => Colors.grey.shade600;
  get bottomSheetIconColor1 => Colors.white;
  get bottomSheetIconColor2 => Colors.green;
}
