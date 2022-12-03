import 'package:flutter/material.dart';

import '../easy_loading.dart';
import '../spinkit/chasing_dots.dart';
import '../spinkit/circle.dart';
import '../spinkit/cube_grid.dart';
import '../spinkit/double_bounce.dart';
import '../spinkit/dual_ring.dart';
import '../spinkit/fading_circle.dart';
import '../spinkit/fading_cube.dart';
import '../spinkit/fading_four.dart';
import '../spinkit/fading_grid.dart';
import '../spinkit/folding_cube.dart';
import '../spinkit/hour_glass.dart';
import '../spinkit/pouring_hour_glass.dart';
import '../spinkit/pulse.dart';
import '../spinkit/pumping_heart.dart';
import '../spinkit/ring.dart';
import '../spinkit/ripple.dart';
import '../spinkit/rotating_circle.dart';
import '../spinkit/rotating_plain.dart';
import '../spinkit/spinning_circle.dart';
import '../spinkit/square_circle.dart';
import '../spinkit/three_bounce.dart';
import '../spinkit/wandering_cubes.dart';
import '../spinkit/wave.dart';
import '../theme.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  final double _size = EasyLoadingTheme.indicatorSize;

  /// indicator color of loading
  final Color _indicatorColor = EasyLoadingTheme.indicatorColor;
  late Widget _indicator;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = _size;

    switch (EasyLoadingTheme.indicatorType) {
      case EasyLoadingIndicatorType.fadingCircle:
        _indicator = SpinKitFadingCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.circle:
        _indicator = SpinKitCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.threeBounce:
        _indicator = SpinKitThreeBounce(
          color: _indicatorColor,
          size: _size,
        );
        width = _size * 2;
        break;

      case EasyLoadingIndicatorType.chasingDots:
        _indicator = SpinKitChasingDots(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.wave:
        _indicator = SpinKitWave(
          color: _indicatorColor,
          size: _size,
          itemCount: 6,
        );
        width = _size * 1.25;
        break;

      case EasyLoadingIndicatorType.wanderingCubes:
        _indicator = SpinKitWanderingCubes(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.rotatingCircle:
        _indicator = SpinKitRotatingCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.rotatingPlain:
        _indicator = SpinKitRotatingPlain(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.doubleBounce:
        _indicator = SpinKitDoubleBounce(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.fadingFour:
        _indicator = SpinKitFadingFour(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.fadingCube:
        _indicator = SpinKitFadingCube(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.pulse:
        _indicator = SpinKitPulse(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.cubeGrid:
        _indicator = SpinKitCubeGrid(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.foldingCube:
        _indicator = SpinKitFoldingCube(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.pumpingHeart:
        _indicator = SpinKitPumpingHeart(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.dualRing:
        _indicator = SpinKitDualRing(
          color: _indicatorColor,
          size: _size,
          lineWidth: EasyLoadingTheme.lineWidth,
        );
        break;

      case EasyLoadingIndicatorType.hourGlass:
        _indicator = SpinKitHourGlass(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.pouringHourGlass:
        _indicator = SpinKitPouringHourGlass(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.fadingGrid:
        _indicator = SpinKitFadingGrid(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.ring:
        _indicator = SpinKitRing(
          color: _indicatorColor,
          size: _size,
          lineWidth: EasyLoadingTheme.lineWidth,
        );
        break;

      case EasyLoadingIndicatorType.ripple:
        _indicator = SpinKitRipple(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.spinningCircle:
        _indicator = SpinKitSpinningCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;

      case EasyLoadingIndicatorType.squareCircle:
        _indicator = SpinKitSquareCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;

      default:
        _indicator = SpinKitFadingCircle(
          color: _indicatorColor,
          size: _size,
        );
        break;
    }

    return Container(
      constraints: BoxConstraints(
        maxWidth: width,
      ),
      child: _indicator,
    );
  }
}
