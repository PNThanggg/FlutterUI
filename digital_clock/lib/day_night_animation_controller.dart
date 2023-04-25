import 'package:digital_clock/flare_animation_time_controller.dart';
import 'package:flare_flutter/flare.dart';

class DayNightAnimationController extends FlareAnimationTimeController {
  static const int _animationLengthSeconds = 24;
  static const _animationName = "midnight";

  final Mat2D _globalToFlareWorld = Mat2D();
  DateTime _animationInitialDateTime;

  DayNightAnimationController(this._animationInitialDateTime);

  late FlutterActorArtboard _artboard;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    //We divide elapsed time by 3600 to run 24sec animation for 24h
    final animationElapse = elapsed / 3600;
    super.advance(artboard, animationElapse);

    return true;
  }

  // Fetch references for the `ctrl_face` node and store a copy of its original translation.
  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
    _artboard = artboard;

    play(
      _animationName,
      time: calculateAnimationStartTime(_animationInitialDateTime),
    );
  }

  // Called by [FlareActor] when the view transform changes.
  // Updates the matrix that transforms Global-Flutter-coordinates into Flare-World-coordinates.
  @override
  void setViewTransform(Mat2D viewTransform) {
    Mat2D.invert(_globalToFlareWorld, viewTransform);
  }

  void resetAnimationTo(DateTime currentTime) {
    _animationInitialDateTime = currentTime;
    initialize(_artboard);
  }

  double calculateAnimationStartTime(DateTime currentTime) {
    final currentDayPassedMinutes =
        (currentTime.hour * Duration.minutesPerHour) + currentTime.minute;
    final currentDayCompletionPercent =
        currentDayPassedMinutes / Duration.minutesPerDay;

    return _animationLengthSeconds * currentDayCompletionPercent;
  }
}
