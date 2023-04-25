// Copyright (c) 2020, David PHAM-VAN. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:spritewidget/spritewidget.dart';

import 'resources.dart' as resources;
import 'world.dart';

/// Snow. Uses 9 particle systems to create a parallax effect of snow at
/// different distances.
class Snow extends Node implements WeatherElement {
  Snow() {
    _addParticles(SpriteTexture(resources.images['assets/flake-0.webp']), 1.5);
    _addParticles(SpriteTexture(resources.images['assets/flake-1.webp']), 1.5);
    _addParticles(SpriteTexture(resources.images['assets/flake-2.webp']), 1.5);

    _addParticles(SpriteTexture(resources.images['assets/flake-3.webp']), 2.0);
    _addParticles(SpriteTexture(resources.images['assets/flake-4.webp']), 2.0);
    _addParticles(SpriteTexture(resources.images['assets/flake-5.webp']), 2.0);

    _addParticles(SpriteTexture(resources.images['assets/flake-6.webp']), 2.5);
    _addParticles(SpriteTexture(resources.images['assets/flake-7.webp']), 2.5);
    _addParticles(SpriteTexture(resources.images['assets/flake-8.webp']), 2.5);
  }

  final List<ParticleSystem> _particles = <ParticleSystem>[];

  void _addParticles(SpriteTexture texture, double distance) {
    final particles = ParticleSystem(texture,
        transferMode: BlendMode.srcATop,
        posVar: const Offset(1300.0, 0.0),
        direction: 90.0,
        directionVar: 0.0,
        speed: 150.0 / distance,
        speedVar: 50.0 / distance,
        startSize: 1.0 / distance,
        startSizeVar: 0.3 / distance,
        endSize: 1.2 / distance,
        endSizeVar: 0.2 / distance,
        life: 20.0 * distance,
        lifeVar: 10.0 * distance,
        emissionRate: 2.0,
        startRotationVar: 360.0,
        endRotationVar: 360.0,
        radialAccelerationVar: 10.0 / distance,
        tangentialAccelerationVar: 10.0 / distance);
    particles.position = const Offset(1024.0, -50.0);
    particles.opacity = 0.0;

    _particles.add(particles);
    addChild(particles);
  }

  @override
  void activate(WeatherCondition weatherType, Brightness brightness) {
    final active = weatherType == WeatherCondition.snowy;

    // Apply changes
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
