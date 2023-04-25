import 'package:flutter/widgets.dart';

/// This allows to configure some features that will not change during
/// the app life
class Flavor extends InheritedWidget {
  const Flavor({
    Key? key,
    required Widget child,
    this.data = _default,
  }) : super(key: key, child: child);

  /// The build-time application settings
  final FlavorData data;

  static const _default = FlavorData();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static FlavorData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Flavor>()?.data ?? _default;
  }
}

/// Application default settings for "production" (the Flutter contest)
/// some parameters can be changed at build time for testing
@immutable
class FlavorData {
  const FlavorData({
    this.isInteractive = false,
    this.isDemo = false,
    this.timeOffset,
    this.animationFactor = 1,
  })  : _weatherFadeDuration = const Duration(seconds: 1),
        _clockAnimateDuration = const Duration(seconds: 1),
        _weatherSizeDuration = const Duration(milliseconds: 200);

  /// Is this an interactive version? The Flutter contest forbidds any interactivity
  /// but it's easier for testing to have some shortcuts.
  final bool isInteractive;

  /// If set, the clock will start at a fixed date and time, in order to
  /// record the video
  final bool isDemo;

  /// Time offset to apply to the current time, used for video recording
  final Duration? timeOffset;

  /// Animation speed divisor
  final double animationFactor;

  /// Duration for the dark/light fading of the top right weather information box
  Duration get weatherFadeDuration => _weatherFadeDuration * animationFactor;
  final Duration _weatherFadeDuration;

  /// Duration for the sizing of the top right weather information box
  /// in case we pass from 'Sunny' to 'Thunderstorm' the box will resize using
  /// this value
  Duration get weatherSizeDuration => _weatherSizeDuration * animationFactor;
  final Duration _weatherSizeDuration;

  /// Date and Time animation duration
  Duration get clockAnimateDuration => _clockAnimateDuration * animationFactor;
  final Duration _clockAnimateDuration;

  /// Helper/Mockable function to get the current Date and Time
  DateTime getTime() {
    if (isDemo && timeOffset != null && timeOffset!.inSeconds < 0) {
      return DateTime.now().subtract(timeOffset!);
    }
    return DateTime.now();
  }
}
