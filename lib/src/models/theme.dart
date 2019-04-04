import 'package:flutter/material.dart';

class MyTheme {
  MyTheme(
      {this.name,
      this.brightness,
      this.backgroundColor,
      this.scaffoldBackgroundColor,
      this.primaryColor,
      this.primaryColorBrightness,
      this.accentColor});

  String name;
  Brightness brightness;
  Color backgroundColor;
  Color scaffoldBackgroundColor;
  Color primaryColor;
  Brightness primaryColorBrightness;
  Color accentColor;
}
