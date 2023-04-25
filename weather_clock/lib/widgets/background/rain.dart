// Copyright (c) 2020, David PHAM-VAN. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:spritewidget/spritewidget.dart';

import 'resources.dart' as resources;
import 'world.dart';

// Rain layer. Uses three layers of particle systems, to create a parallax
// rain effect.
class Rain extends Node implements WeatherElement {
  Rain() {
    _addParticles(1.0);
    _addParticles(1.5);
    _addParticles(2.0);
  }

  final _particles = <ParticleSystem>[];

  void _addParticles(double distance) {
    final particles = ParticleSystem(
        SpriteTexture(resources.images['assets/raindrop.webp']),
        transferMode: BlendMode.srcATop,
        posVar: const Offset(1300.0, 0.0),
        direction: 90.0,
        directionVar: 0.0,
        speed: 1000.0 / distance,
        speedVar: 100.0 / distance,
        startSize: 1.2 / distance,
        startSizeVar: 0.2 / distance,
        endSize: 1.2 / distance,
        endSizeVar: 0.2 / distance,
        life: 1.5 * distance,
        lifeVar: 1.0 * distance);
    particles.position = const Offset(1024.0, -200.0);
    particles.rotation = 10.0;
    particles.opacity = 0.0;

    _particles.add(particles);
    addChild(particles);
  }

  @override
  void activate(WeatherCondition weatherType, Brightness brightness) {
    final active = weatherType == WeatherCondition.rainy ||
        weatherType == WeatherCondition.thunderstorm;

    // Toggle visibility of the rain
    motions.stopAll();
    for (var system in _particles) {
      if (active) {
        motions.run(
          MotionTween<double>(
              (a) => system.opacity = a, system.opacity, 1.0, 2.0),
        );
      } else {
        motions.run(
          MotionTween<double>(
              (a) => system.opacity = a, system.opacity, 0.0, 0.5),
        );
      }
    }
  }
}
