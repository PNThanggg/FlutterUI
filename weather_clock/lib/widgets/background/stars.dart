// Copyright (c) 2020, David PHAM-VAN. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';
import 'dart:ui';

import 'package:flutter_clock_helper/model.dart';
import 'package:spritewidget/spritewidget.dart';

import 'world.dart';

/// Create a star sky with slow rotation and breathing stars
class Stars extends NodeWithSize implements WeatherElement {
  Stars() : super(const Size(2048, 2048)) {
    pivot = const Offset(.5, .5);
    position = const Offset(1024, 1024);

    final rnd = Random();
    for (var index = 0; index < 200; index++) {
      final size = rnd.nextDouble() * 3 + 2;

      final star = Star(
        Rect.fromLTWH(
          rnd.nextDouble() * 2048,
          rnd.nextDouble() * 2048,
          size,
          size,
        ),
        rnd.nextDouble(),
      );

      addChild(star);
    }
  }

  double opacity = 0.0;

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

    // Toggle visibility
    motions.stopAll();

    double targetOpacity;
    if (!active) {
      targetOpacity = 0.0;
    } else {
      targetOpacity = 1.0;
    }

    motions.run(
      MotionTween<double>((a) => opacity = a, opacity, targetOpacity, 2.0),
    );
  }

  @override
  void paint(Canvas canvas) {
    applyTransformForPivot(canvas);
  }

  @override
  void update(double dt) {
    rotation += 1.0 * dt;
  }
}

/// One star
class Star extends Node {
  Star(this.rect, this.glow);

  final Rect rect;
  double glow;
  double glowDirection = -1;
  double glowSpeed = .5;

  @override
  void paint(Canvas canvas) {
    final p = parent;
    final opacity = p is Stars ? p.opacity : 1;
    var color = 0xffffff;
    color |= ((glow * opacity * 0xff).toInt() & 0xff) << 24;
    canvas.drawCircle(
        rect.center, rect.width / 2, Paint()..color = Color(color));
  }

  @override
  void update(double dt) {
    glow += dt * glowDirection * glowSpeed;
    if (glow < .3) {
      glow = .3;
      glowDirection = 1;
    } else if (glow > 1) {
      glow = 1;
      glowDirection = -1;
    }
  }
}
