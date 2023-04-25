// Copyright (c) 2020, David PHAM-VAN. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:spritewidget/spritewidget.dart';

import 'resources.dart' as resources;
import 'sky.dart';
import 'world.dart';

/// Thunder flashes composed of 2 sprites and a fullscreen white sky,
/// all animated with some random durations and positions
class Thunder extends Node implements WeatherElement {
  Thunder() {
    _addThunder(SpriteTexture(resources.images['assets/thunder-0.webp']));
    _addThunder(SpriteTexture(resources.images['assets/thunder-1.webp']));

    _sky = GradientNode(
      const Size(2048, 2048),
      <Color>[const Color(0x9fffffff), const Color(0x00f9efff)],
    );
    _sky.visible = false;
    addChild(_sky);
  }

  bool _active = false;
  final List<Sprite> _flashes = <Sprite>[];
  GradientNode _sky;

  void _addThunder(SpriteTexture texture) {
    final thunder = Sprite(texture);
    thunder.visible = false;
    addChild(thunder);
    _flashes.add(thunder);
  }

  @override
  void activate(WeatherCondition weatherType, Brightness brightness) {
    final active = weatherType == WeatherCondition.thunderstorm;

    // Toggle visibility of the flashes
    _active = active;
    motions.stopAll();

    _sky.visible = false;
    for (var flash in _flashes) {
      if (active) {
        flash.visible = false;
        _animate(flash);
      } else {
        flash.visible = false;
      }
    }
  }

  void _animate(Sprite flash) async {
    while (_active) {
      flash.scale = randomDouble() * 1.3 + .7;
      if (randomBool()) flash.scaleX = -flash.scaleX;
      flash.rotation = randomSignedDouble() * 10;
      flash.position =
          Offset(randomDouble() * 2048, randomDouble() * 512 + 768);
      final delay = randomDouble() * 5 + 1;
      final duration = randomDouble() * .4 + .15;
      final finished = Completer<void>();
      motions.run(
        MotionSequence(
          [
            MotionDelay(delay),
            MotionCallFunction(() {}),
            MotionTween<double>((a) {
              flash.visible = randomDouble() > .4;
              _sky.visible = flash.visible;
            }, 1, 0, duration),
            MotionCallFunction(() {
              flash.visible = false;
              _sky.visible = false;
              finished.complete();
            }),
          ],
        ),
      );

      await finished.future;
    }
  }
}
