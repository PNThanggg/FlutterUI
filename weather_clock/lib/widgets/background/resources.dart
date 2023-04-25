// Copyright (c) 2020, David PHAM-VAN. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:spritewidget/spritewidget.dart';

/// Map of all image assets.
ImageMap images;

/// Return the gradient colors for the current weather
List<Color> gradientColors(
  WeatherCondition weatherType,
  Brightness brightness,
) {
  return <Color>[
    _backgroundColorsTop[weatherType][brightness] ??
        _backgroundColorsTop[weatherType][Brightness.light],
    _backgroundColorsBottom[weatherType][brightness] ??
        _backgroundColorsBottom[weatherType][Brightness.light],
  ];
}

/// Preload all images
Future<void> loadAssets(AssetBundle bundle) async {
  print('Load assets');

  // Load images using an ImageMap
  images = ImageMap(bundle);
  await images.load(<String>[
    'assets/clouds-0.webp',
    'assets/clouds-1.webp',
    'assets/ray.webp',
    'assets/sun.webp',
    'assets/moon.webp',
    'assets/moon-light.webp',
    'assets/flake-0.webp',
    'assets/flake-1.webp',
    'assets/flake-2.webp',
    'assets/flake-3.webp',
    'assets/flake-4.webp',
    'assets/flake-5.webp',
    'assets/flake-6.webp',
    'assets/flake-7.webp',
    'assets/flake-8.webp',
    'assets/raindrop.webp',
    'assets/thunder-0.webp',
    'assets/thunder-1.webp',
  ]);
}

/// Colors for the top side of the background gradients
const _backgroundColorsTop = <WeatherCondition, Map<Brightness, Color>>{
  WeatherCondition.sunny: {
    Brightness.light: Color(0xff5ebbd5),
    Brightness.dark: Color(0xff140034),
  },
  WeatherCondition.rainy: {
    Brightness.light: Color(0xff0b2734),
  },
  WeatherCondition.snowy: {
    Brightness.light: Color(0xffcbced7),
  },
  WeatherCondition.foggy: {
    Brightness.light: Color(0xffcbced7),
  },
  WeatherCondition.cloudy: {
    Brightness.light: Color(0xff0b2734),
    Brightness.dark: Color(0xff140034),
  },
  WeatherCondition.thunderstorm: {
    Brightness.light: Color(0xff0b2734),
  },
  WeatherCondition.windy: {
    Brightness.light: Color(0xff5ebbd5),
    Brightness.dark: Color(0xff140034),
  },
};

/// Colors for the bottom side of the background gradients
const _backgroundColorsBottom = <WeatherCondition, Map<Brightness, Color>>{
  WeatherCondition.sunny: {
    Brightness.light: Color(0xff4aaafb),
    Brightness.dark: Color(0xff000000),
  },
  WeatherCondition.rainy: {
    Brightness.light: Color(0xff4c5471),
  },
  WeatherCondition.snowy: {
    Brightness.light: Color(0xffe0e3ec),
  },
  WeatherCondition.foggy: {
    Brightness.light: Color(0xffe0e3ec),
  },
  WeatherCondition.cloudy: {
    Brightness.light: Color(0xff4c5471),
    Brightness.dark: Color(0xff000000),
  },
  WeatherCondition.thunderstorm: {
    Brightness.light: Color(0xff4c5471),
    Brightness.dark: Color(0xff241064),
  },
  WeatherCondition.windy: {
    Brightness.light: Color(0xff4aaafb),
    Brightness.dark: Color(0xff000000),
  },
};
