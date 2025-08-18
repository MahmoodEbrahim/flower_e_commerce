import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color White=Color(0xFFF9F9F9);
  static const Color gray=Color(0xFF535353);
  //static const Color lightGray=Color(0xFF535353);
  static const Color red=Color(0xFFCC1010);
  static const Color green=Color(0xFF11CE19);
  static const Color Black=Color(0xFF000000);
  static const Color lightPink=Color(0xFFF9ECF0);
  static const Color Pink=Color(0xFFD21E6A);


  static MaterialColor pink=MaterialColor(0xFF02369C, <int , Color>{
    10: Color(0xFFf6d2e1),
    20: Color(0xFFf0b4cd),
    30: Color(0xFFe98fb5),
    40: Color(0xFFe1699c),
    50: Color(0xFFda4483),
    60: Color(0xFFaf1958),
    70: Color(0xFF8c1447),
    80: Color(0xFF690f35),
    90: Color(0xFF460a23),
    100: Color(0xFF2a0615),
  });


  static MaterialColor black=MaterialColor(0xFF0f0f0f, <int , Color>{
    10: Color(0xFFcfcfcf),
    20: Color(0xFFafafaf),
    30: Color(0xFF878787),
    40: Color(0xFF5f5f5f),
    50: Color(0xFF373737),

    60: Color(0xFF0d0d0d),
    70: Color(0xFF0a0a0a),
    80: Color(0xFF080808),
    90: Color(0xFF050505),
    100: Color(0xFF030303),
  });


  static MaterialColor white=MaterialColor(0xFF0f0f0f, <int , Color>{
    10: Color(0xFFfefefe),
    20: Color(0xFFfdfdfd),
    30: Color(0xFFfcfcfc),
    40: Color(0xFFfbfbfb),
    50: Color(0xFFfafafa),
    60: Color(0xFFd0d0d0),
    70: Color(0xFFa6a6a6),
    80: Color(0xFF7d7d7d),
    90: Color(0xFF535353),
    100: Color(0xFF323232),
  });
}