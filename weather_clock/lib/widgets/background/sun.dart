// Copyright (c) 2020, David PHAM-VAN. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:spritewidget/spritewidget.dart';

import 'resources.dart' as resources;
import 'world.dart';

const double _kNumSunRays = 50.0;

/// Create an animated sun with rays
class Sun extends Node implements WeatherElement {
  Sun() {
    scale = 1.5;
    // Create the sun
    _sun = Sprite.fromImage(resources.images['assets/sun.webp']);
    _sun.scale = 4.0;
    _sun.transferMode = BlendMode.plus;
    _sun.opacity = 0;
    addChild(_sun);

    // Create rays
    _rays = <Ray>[];
    for (var i = 0; i < _kNumSunRays; i += 1) {
      final ray = Ray();
      ray.opacity = 0;
      addChild(ray);
      _rays.add(ray);
    }
  }

  Sprite _sun;
  List<Ray> _rays;

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

    if (brightness == Brightness.dark) active = false;

    // Toggle visibility of the sun
    motions.stopAll();

    double targetOpacity;
    if (!active) {
      targetOpacity = 0.0;
    } else {
      targetOpacity = 1.0;
    }

    motions.run(
      MotionTween<double>(
          (a) => _sun.opacity = a, _sun.opacity, targetOpacity, 2.0),
    );

    if (active &&
        (weatherType == WeatherCondition.sunny ||
            weatherType == WeatherCondition.windy)) {
      for (var ray in _rays) {
        motions.run(
          MotionSequence(
            <Motion>[
              MotionDelay(1.5),
              MotionTween<double>(
                  (a) => ray.opacity = a, ray.opacity, ray.maxOpacity, 1.5)
            ],
          ),
        );
      }
    } else {
      for (var ray in _rays) {
        motions.run(
          MotionTween<double>((a) => ray.opacity = a, ray.opacity, 0.0, 0.2),
        );
      }
    }
  }
}

/// An animated sun ray
class Ray extends Sprite {
  Ray() : super.fromImage(resources.images['assets/ray.webp']) {
    pivot = const Offset(0.0, 0.5);
    transferMode = BlendMode.plus;
    rotation = randomDouble() * 360.0;
    maxOpacity = randomDouble() * 0.2;
    opacity = maxOpacity;
    scaleX = 2.5 + randomDouble();
    scaleY = 0.3;
    _rotationSpeed = randomSignedDouble() * 2.0;

    // Scale animation
    final scaleTime = randomSignedDouble() * 2.0 + 4.0;

    motions.run(
      MotionRepeatForever(
        MotionSequence(
          <Motion>[
            MotionTween<double>(
                (a) => scaleX = a, scaleX, scaleX * 0.5, scaleTime),
            MotionTween<double>(
                (a) => scaleX = a, scaleX * 0.5, scaleX, scaleTime)
          ],
        ),
      ),
    );
  }

  double _rotationSpeed;
  double maxOpacity;

  @override
  void update(double dt) {
    rotation += dt * _rotationSpeed;
  }
}
