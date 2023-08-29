import 'package:flutter/material.dart';

class Pallete {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;

  static const Map<int, Color> primaryColor = {
    50: Color.fromRGBO(35, 40, 107, .1),
    100: Color.fromRGBO(35, 40, 107, .2),
    200: Color.fromRGBO(35, 40, 107, .3),
    300: Color.fromRGBO(35, 40, 107, .4),
    400: Color.fromRGBO(35, 40, 107, .5),
    500: Color.fromRGBO(35, 40, 107, .6),
    600: Color.fromRGBO(35, 40, 107, .7),
    700: Color.fromRGBO(35, 40, 107, .8),
    800: Color.fromRGBO(35, 40, 107, .9),
    900: Color.fromRGBO(35, 40, 107, 1),
  };

  static var appTheme = ThemeData(
    primarySwatch: const MaterialColor(0xFF23286B, primaryColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 2,
      iconTheme: IconThemeData(
        color: Color(0xFF23286B),
        size: 20,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    fontFamily: 'Circular Std',
  );
}
