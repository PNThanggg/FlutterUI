import 'package:flutter/material.dart';

import 'customizer.dart';
import 'digital_clock.dart';
import 'model.dart';

void main() {
  runApp(ClockCustomizer((ClockModel model) => DigitalClock(model)));
}
