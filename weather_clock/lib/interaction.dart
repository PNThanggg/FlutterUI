import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// This widget allow some Keyboard interactions. This works only with
/// Android, Web, and macOS.
/// * Numbers from 1 to 7 can change the weather.
/// * s => Sunny
/// * c => Cloudy
/// * f => Foggy
/// * r => Rainy
/// * n => Snowy
/// * t => Thunderstorm
/// * w => Windy
/// * 0 => Toggle is24HourFormat
/// * d => Starts the automatic "demo" for the video recording
/// * <space> Toggle dark and light theme
class ClockInteraction extends StatefulWidget {
  const ClockInteraction({@required this.child});

  final Widget child;

  @override
  _ClockInteractionState createState() => _ClockInteractionState();
}

class _ClockInteractionState extends State<ClockInteraction> {
  final FocusNode _focusNode = FocusNode();
  Brightness _brightness = Brightness.light;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _demo() {
    final model = Provider.of<ClockModel>(context, listen: false);

    // Start with a sunny weather
    setState(() {
      model.weatherCondition = WeatherCondition.sunny;
      _brightness = Brightness.light;
    });
    Timer(const Duration(seconds: 5), () {
      // Switch to cloudy
      setState(() {
        model.weatherCondition = WeatherCondition.cloudy;
      });
      Timer(const Duration(seconds: 5), () {
        // Then to a thunderstorm
        setState(() {
          model.weatherCondition = WeatherCondition.thunderstorm;
        });
        Timer(const Duration(seconds: 6), () {
          // Night!
          setState(() {
            _brightness = Brightness.dark;
          });
          Timer(const Duration(seconds: 4), () {
            // Switch to a cloudy night
            setState(() {
              model.weatherCondition = WeatherCondition.cloudy;
            });
            Timer(const Duration(seconds: 5), () {
              // Finish with a full moon
              setState(() {
                model.weatherCondition = WeatherCondition.sunny;
              });
              Timer(const Duration(seconds: 5), () {
                // And back to sun
                setState(() {
                  _brightness = Brightness.light;
                });
              });
            });
          });
        });
      });
    });
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (!(event is RawKeyDownEvent)) return;

    final model = Provider.of<ClockModel>(context, listen: false);

    switch (event.logicalKey.keyLabel) {
      case 'c':
      case '1':
        setState(() {
          model.weatherCondition = WeatherCondition.cloudy;
        });
        break;
      case 'f':
      case '2':
        setState(() {
          model.weatherCondition = WeatherCondition.foggy;
        });
        break;
      case 'r':
      case '3':
        setState(() {
          model.weatherCondition = WeatherCondition.rainy;
        });
        break;
      case 'n':
      case '4':
        setState(() {
          model.weatherCondition = WeatherCondition.snowy;
        });
        break;
      case 's':
      case '5':
        setState(() {
          model.weatherCondition = WeatherCondition.sunny;
        });
        break;
      case 't':
      case '6':
        setState(() {
          model.weatherCondition = WeatherCondition.thunderstorm;
        });
        break;
      case 'w':
      case '7':
        setState(() {
          model.weatherCondition = WeatherCondition.windy;
        });
        break;
      case ' ':
        setState(() {
          _brightness = _brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light;
        });
        break;
      case '0':
        setState(() {
          model.is24HourFormat = !model.is24HourFormat;
        });
        break;
      case 'd':
        _demo();
        break;
      default:
        print('Key pressed: ${event.logicalKey.keyLabel}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_focusNode.hasFocus && FocusScope.of(context).focusedChild == null) {
      FocusScope.of(context).requestFocus(_focusNode);
    }

    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(brightness: _brightness),
      child: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        child: widget.child,
      ),
    );
  }
}
