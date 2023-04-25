import 'dart:ui' as ui show Image;

import 'package:flutter/material.dart';

import '../../spritewidget/spritewidget.dart';
import 'resources.dart' as resources;
import 'world.dart';

/// Draws and animates a cloud layer using two sprites.
abstract class CloudLayer extends Node implements WeatherElement {
  CloudLayer({ui.Image image, bool rotated, double loopTime}) {
    // Creates and positions the two cloud sprites.
    _sprites.add(_createSprite(image, rotated));
    _sprites[0].position = const Offset(1024.0, 1024.0);
    _sprites[0].opacity = 0.0;
    _sprites[0].colorOverlay = const Color(0xffffffff);
    addChild(_sprites[0]);

    _sprites.add(_createSprite(image, rotated));
    _sprites[1].position = const Offset(3072.0, 1024.0);
    _sprites[1].opacity = 0.0;
    _sprites[1].colorOverlay = const Color(0xffffffff);
    addChild(_sprites[1]);

    // Animate the clouds across the screen.
    _motion = MotionRepeatForever(
      MotionTween<Offset>(
        (a) => position = a,
        Offset.zero,
        const Offset(-2048.0, 0.0),
        loopTime,
      ),
    );

    motions.run(_motion);
  }

  Motion _motion;

  final List<Sprite> _sprites = <Sprite>[];

  @protected
  void setDark(bool value) {
    Color targetColorOverlay;
    if (value) {
      targetColorOverlay = const Color(0xff000000);
    } else {
      targetColorOverlay = const Color(0xffffffff);
    }

    for (var sprite in _sprites) {
      motions.run(
        MotionTween<Color>(
          (a) => sprite.colorOverlay = a,
          sprite.colorOverlay,
          targetColorOverlay,
          1.0,
        ),
      );
    }
  }

  Sprite _createSprite(ui.Image image, bool rotated) {
    final sprite = Sprite.fromImage(image);

    if (rotated) sprite.scaleX = -1.0;

    return sprite;
  }

  @protected
  void setActive(bool active) {
    // Toggle visibility of the cloud layer
    double opacity;
    if (active) {
      opacity = 1.0;
    } else {
      opacity = 0.0;
    }

    for (var sprite in _sprites) {
      sprite.motions.stopAll();
      sprite.motions.run(
        MotionTween<double>((a) => sprite.opacity = a, sprite.opacity, opacity, 1.0),
      );
    }
  }
}

/// High density clouds
class CloudsSharp extends CloudLayer {
  CloudsSharp()
      : super(
          image: resources.images['assets/clouds-0.webp'],
          rotated: false,
          loopTime: 20.0,
        );

  @override
  void activate(WeatherCondition weatherType, Brightness brightness) {
    final active = weatherType != WeatherCondition.sunny && weatherType != WeatherCondition.windy;

    setActive(active);
    setDark(brightness == Brightness.dark);
  }
}

/// Low density clouds with faster speed to simulate windy weather
class CloudsFast extends CloudLayer {
  CloudsFast()
      : super(
          image: resources.images['assets/clouds-0.webp'],
          rotated: false,
          loopTime: 5.0,
        );

  @override
  void activate(WeatherCondition weatherType, Brightness brightness) {
    final active = weatherType == WeatherCondition.windy;

    setActive(active);
    setDark(brightness == Brightness.dark);
  }
}

/// Always dark low density clouds
class CloudsDark extends CloudLayer {
  CloudsDark()
      : super(
          image: resources.images['assets/clouds-1.webp'],
          rotated: true,
          loopTime: 40.0,
        );

  @override
  void activate(WeatherCondition weatherType, Brightness brightness) {
    final active = weatherType != WeatherCondition.sunny &&
        weatherType != WeatherCondition.windy &&
        weatherType != WeatherCondition.cloudy;

    setActive(active);
    setDark(true);
  }
}

/// Low density clouds
class CloudsSoft extends CloudLayer {
  CloudsSoft()
      : super(
          image: resources.images['assets/clouds-1.webp'],
          rotated: false,
          loopTime: 60.0,
        );

  @override
  void activate(WeatherCondition weatherType, Brightness brightness) {
    setActive(true);
    setDark(brightness == Brightness.dark);
  }
}
