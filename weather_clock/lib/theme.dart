import 'package:flutter/material.dart';

/// Theme for the specific widgets of this application
class ClockTheme {
  const ClockTheme._({
    required this.background,
    required this.time,
    required this.date,
    required this.temperature,
    required this.weather,
    required this.shadeBox,
  });

  /// General background color
  final Color background;

  /// Time text style
  final TextStyle time;

  /// Date text style
  final TextStyle date;

  /// Temperature text style
  final TextStyle temperature;

  /// Weather text style
  final TextStyle weather;

  /// Top right weather information box background color
  final Color shadeBox;

  /// Get the current theme
  static ClockTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light ? _light : _dark;
  }

  /// Light theme
  static const _light = ClockTheme._(
    background: Colors.white,
    time: TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 50,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 10.0,
          color: Colors.black38,
        ),
      ],
    ),
    date: TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 15,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 10.0,
          color: Colors.black38,
        ),
      ],
    ),
    temperature: TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 30,
    ),
    weather: TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 15,
    ),
    shadeBox: Colors.black26,
  );

  /// Dark theme
  static const _dark = ClockTheme._(
    background: Color(0xFF424242),
    time: TextStyle(
      color: Colors.black,
      fontFamily: 'OpenSans',
      fontSize: 50,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 15.0,
          color: Colors.white70,
        ),
      ],
    ),
    date: TextStyle(
      color: Colors.black,
      fontFamily: 'OpenSans',
      fontSize: 15,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 10.0,
          color: Colors.white70,
        ),
      ],
    ),
    temperature: TextStyle(
      color: Color(0xff140035),
      fontFamily: 'OpenSans',
      fontSize: 30,
    ),
    weather: TextStyle(
      color: Color(0xff140035),
      fontFamily: 'OpenSans',
      fontSize: 15,
    ),
    shadeBox: Colors.white24,
  );
}
