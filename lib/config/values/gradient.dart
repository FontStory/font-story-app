import 'package:flutter/material.dart'
    show AlignmentDirectional, Color, Gradient, LinearGradient;

class AppGradient {
  AppGradient._();

  static const Gradient sunsetBlaze = LinearGradient(
    begin: AlignmentDirectional.topEnd,
    end: AlignmentDirectional.bottomStart,
    colors: [Color.fromRGBO(255, 195, 113, 1), Color.fromRGBO(255, 95, 109, 1)],
  );

  static const Gradient peachWhisper = LinearGradient(
    begin: AlignmentDirectional.topEnd,
    end: AlignmentDirectional.bottomStart,
    colors: [
      Color.fromRGBO(250, 208, 196, 1),
      Color.fromRGBO(255, 154, 158, 1),
    ],
  );

  static const Gradient lavenderDreams = LinearGradient(
    begin: AlignmentDirectional.topEnd,
    end: AlignmentDirectional.bottomStart,
    colors: [
      Color.fromRGBO(251, 194, 235, 1),
      Color.fromRGBO(161, 140, 209, 1),
    ],
  );

  static const Gradient skyDrift = LinearGradient(
    begin: AlignmentDirectional.topEnd,
    end: AlignmentDirectional.bottomStart,
    colors: [
      Color.fromRGBO(194, 233, 251, 1),
      Color.fromRGBO(161, 196, 253, 1),
    ],
  );

  static const Gradient vibrantAqua = LinearGradient(
    begin: AlignmentDirectional.topEnd,
    end: AlignmentDirectional.bottomStart,
    colors: [Color.fromRGBO(20, 220, 160, 1), Color.fromRGBO(100, 180, 245, 1)],
  );

  static const Gradient pinkRush = LinearGradient(
    begin: AlignmentDirectional.topEnd,
    end: AlignmentDirectional.bottomStart,
    colors: [
      Color.fromRGBO(255, 117, 140, 1),
      Color.fromRGBO(255, 126, 179, 1),
    ],
  );

  static const Gradient mistyGraphite = LinearGradient(
    begin: AlignmentDirectional.topEnd,
    end: AlignmentDirectional.bottomStart,
    colors: [Color(0xFF616161), Color(0xFF212121)],
  );
}
