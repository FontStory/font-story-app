import 'package:flutter/material.dart' show Color, Colors;

class AppPalette {
  AppPalette._();

  static Color splash = const Color(0xff007ECC);

  // Vibrant Colors
  static Color primaryPink = const Color.fromRGBO(255, 117, 140, 1);
  static const Color primaryBlaze = Color.fromRGBO(255, 95, 109, 1);
  static const Color primaryPeach = Color.fromRGBO(255, 154, 158, 1);
  static const Color primaryLavender = Color.fromRGBO(161, 140, 209, 1);

  // Natural Colors
  static const Color primaryMint = Color.fromRGBO(100, 180, 245, 1);
  static const Color primarySky = Color.fromRGBO(161, 196, 253, 1);

  // Monochrome Tones
  static const Color primaryGray = Color(0xFF616161);

  // Brand Colors
  static const Color instagram = Color(0xFFE1306C);
  static const Color telegram = Color(0xFF0088CC);
  static const Color whatsapp = Color(0xFF25D366);

  static Color dark = const Color(0xff0B0E16);
  static Color green = const Color(0xff34C759);
  static Color red = const Color(0xffFF3B30);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);

  static const List<Color> colorList = [
    Colors.white,
    Colors.black,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];
}
