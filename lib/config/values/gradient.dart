import 'package:flutter/material.dart'
    show Alignment, Color, Gradient, LinearGradient;

class AppGradient {
  AppGradient._();

  static const Gradient sunsetBlaze = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color.fromRGBO(255, 195, 113, 1), Color.fromRGBO(255, 95, 109, 1)],
  );

  static const Gradient peachWhisper = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color.fromRGBO(250, 208, 196, 1),
      Color.fromRGBO(255, 154, 158, 1),
    ],
  );

  static const Gradient lavenderDreams = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color.fromRGBO(251, 194, 235, 1),
      Color.fromRGBO(161, 140, 209, 1),
    ],
  );

  static const Gradient skyDrift = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color.fromRGBO(194, 233, 251, 1),
      Color.fromRGBO(161, 196, 253, 1),
    ],
  );

  static const Gradient vibrantAqua = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color.fromRGBO(20, 220, 160, 1), Color.fromRGBO(100, 180, 245, 1)],
  );

  static const Gradient pinkRush = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color.fromRGBO(255, 117, 140, 1),
      Color.fromRGBO(255, 126, 179, 1),
    ],
  );

  static const Gradient mistyGraphite = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFF616161), Color(0xFF212121)],
  );

  static const List<Gradient> gradientList = [
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF0061FF), Color(0xFF60EFFF)],
    ),
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFff5858), Color(0xFFffc8c8)],
    ),
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFff930f), Color(0xFFfff95b)],
    ),
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFf40752), Color(0xFFf9ab8f)],
    ),
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF30c67c), Color(0xFF82f4b1)],
    ),
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF0e0725),
        Color(0xFF5c03bc),
        Color(0xFFe536ab),
        Color(0xFFf4e5f0),
      ],
    ),
  ];
}
