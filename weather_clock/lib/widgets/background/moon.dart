// Copyright (c) 2020, David PHAM-VAN. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter_clock_helper/model.dart';
import 'package:spritewidget/spritewidget.dart';

import 'resources.dart' as resources;
import 'world.dart';

// Create a moon with a configurable glowing area
class Moon extends Node implements WeatherElement {
  Moon() {
    _moon = Sprite.fromImage(resources.images['assets/moon.webp']);
    _moon.opacity = 0;
    addChild(_moon);

    _glow = Sprite.fromImage(resources.images['assets/moon-light.webp']);
    _glow.opacity = 0;
    addChild(_glow);
  }

  Sprite _moon;

  Sprite _glow;

  @override
  void activate(WeatherCondition weatherType, Brightness brightness) {
    bool active;

    switch (weatherType) {
      case WeatherCondition.cloudy:
      case WeatherCondition.sunny:
      case WeatherCondition.windy:
        active = true;
        break;
      default:
        active = false;
    }

    if (brightness == Brightness.light) active = false;

    // Toggle visibility of the moon
    motions.stopAll();

    double targetOpacity;
    double targetGlowSizeX;
    double targetGlowSizeY;
    if (!active) {
      targetOpacity = 0.0;
    } else {
      targetOpacity = 1.0;
    }

    if (weatherType == WeatherCondition.sunny) {
      targetGlowSizeX = .7;
      targetGlowSizeY = .7;
    } else {
      targetGlowSizeX = 2;
      targetGlowSizeY = 1;
    }

    motions.run(
      MotionTween<double>((a) {
        _moon.opacity = a;
        _glow.opacity = a;
      }, _moon.opacity, targetOpacity, 2.0),
    );

    motions.run(
      MotionTween<double>((a) {
        _glow.scaleX = a;
      }, _glow.scaleX, targetGlowSizeX, 2.0),
    );

    motions.run(
      MotionTween<double>((a) {
        _glow.scaleY = a;
      }, _glow.scaleY, targetGlowSizeY, 2.0),
    );
  }
}
