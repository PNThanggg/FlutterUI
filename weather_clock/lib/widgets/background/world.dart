import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../model.dart';
import '../../spritewidget/spritewidget.dart';
import 'clouds.dart';
import 'moon.dart';
import 'rain.dart';
import 'resources.dart' as resources;
import 'sky.dart';
import 'snow.dart';
import 'stars.dart';
import 'sun.dart';
import 'thunder.dart';

/// Interaction interface used for each element to decide if they show or not
abstract class WeatherElement {
  void activate(WeatherCondition weatherType, Brightness brightness);
}

/// The WeatherWorld is the root canvas scaled to fit the screen
class WeatherWorld extends NodeWithSize {
  WeatherWorld(this._weatherType, this._brightness) : super(const Size(2048.0, 2048.0)) {
    _background = GradientNode(
      size,
      resources.gradientColors(weatherType, _brightness),
    );

    addChild(_background);
    addChild(_stars);
    addChild(_moon);
    addChild(_cloudsSharp);
    addChild(_cloudsFast);
    addChild(_cloudsDark);
    addChild(_cloudsSoft);
    addChild(_sun);
    addChild(_rain);
    addChild(_snow);
    addChild(_thunder);

    _updateWorld();
  }

  GradientNode _background;
  final _cloudsSharp = CloudsSharp();
  final _cloudsFast = CloudsFast();
  final _cloudsSoft = CloudsSoft();
  final _cloudsDark = CloudsDark();
  final _sun = Sun();
  final _moon = Moon();
  final _stars = Stars();
  final _rain = Rain();
  final _snow = Snow();
  final _thunder = Thunder();

  /// Change the weather type to simulate
  WeatherCondition get weatherType => _weatherType;
  WeatherCondition _weatherType;

  set weatherType(WeatherCondition value) {
    assert(value != null);
    if (value == _weatherType) return;

    if(kDebugMode) {
      print('Change weather type to $value');
    }

    _weatherType = value;
    _updateWorld();
  }

  /// Change to day or night condition
  Brightness get brightness => _brightness;
  Brightness _brightness;

  set brightness(Brightness value) {
    assert(value != null);
    if (value == _brightness) return;
    print('Change brightness type to $value');
    _brightness = value;
    _updateWorld();
  }

  void _updateWorld() {
    // Fade the background from one gradient to another.
    _background.motions.stopAll();
    final colors = resources.gradientColors(weatherType, brightness);
    _background.motions.run(
      MotionTween<Color>(
        (a) => _background.colors[0] = a,
        _background.colors[0],
        colors[0],
        1.0,
      ),
    );

    _background.motions.run(
      MotionTween<Color>(
        (a) => _background.colors[1] = a,
        _background.colors[1],
        colors[1],
        1.0,
      ),
    );

    // Activate/deactivate sun, rain, snow, and dark clouds, ...
    _moon.activate(_weatherType, _brightness);
    _sun.activate(_weatherType, _brightness);
    _stars.activate(_weatherType, _brightness);
    _snow.activate(_weatherType, _brightness);
    _rain.activate(_weatherType, _brightness);
    _thunder.activate(_weatherType, _brightness);
    _cloudsDark.activate(_weatherType, _brightness);
    _cloudsSharp.activate(_weatherType, _brightness);
    _cloudsFast.activate(_weatherType, _brightness);
    _cloudsSoft.activate(_weatherType, _brightness);
  }

  @override
  void spriteBoxPerformedLayout() {
    // If the device is rotated or if the size of the SpriteWidget changes we
    // are adjusting the position of the sun.
    _sun.position = spriteBox.visibleArea.topLeft + const Offset(350.0, 180.0);
    _moon.position = spriteBox.visibleArea.topLeft + const Offset(350.0, 180.0);
  }
}
