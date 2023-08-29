import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double horizontalBlockSize;
  static late double verticalBlockSize;
  static late double textScaleFactor;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    textScaleFactor = mediaQueryData.textScaleFactor;
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    horizontalBlockSize = screenWidth / 100;
    verticalBlockSize = screenHeight / 100;
  }
}
