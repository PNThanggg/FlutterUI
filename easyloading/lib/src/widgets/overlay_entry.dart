import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

T? _ambiguate<T>(T? value) => value;

class EasyLoadingOverlayEntry extends OverlayEntry {
  final WidgetBuilder builder;

  EasyLoadingOverlayEntry({
    required this.builder,
  }) : super(builder: builder);

  @override
  void markNeedsBuild() {
    if (_ambiguate(SchedulerBinding.instance)!.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      _ambiguate(SchedulerBinding.instance)!.addPostFrameCallback((_) {
        super.markNeedsBuild();
      });
    } else {
      super.markNeedsBuild();
    }
  }
}
