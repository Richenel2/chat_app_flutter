import 'package:flutter/material.dart';

class MyColor {
  static const primaryGreen = Color(0xFF17C13F);
  static const primaryGray = Color(0xFF2D2D2D);
  static const secondaryGray = Color(0xFFECEAEA);
}

class MyFont {
  static const title = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 35,
    color: MyColor.primaryGray,
  );

  static const normal = TextStyle(fontSize: 16, color: MyColor.primaryGray);

  static const button = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold
  );

}
