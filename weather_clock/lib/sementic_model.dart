import 'package:intl/intl.dart';

import 'model.dart';

/// Add missing functions to the imposed ClockModel class
extension SementicClockModel on ClockModel {
  static final numberFormat = NumberFormat.decimalPattern();

  /// Full text degree(s)
  String degrees(value) => Intl.plural(
        value,
        zero: 'degrees',
        one: 'degree',
        other: 'degrees',
      );

  /// current temperature as a string that can be passed to TTS
  String get sementicTemperature {
    final temp = '${numberFormat.format(temperature)} ${degrees(temperature)}';

    switch (unit) {
      case TemperatureUnit.fahrenheit:
        return '$temp Fahrenheit';
      case TemperatureUnit.celsius:
      default:
        return '$temp Celsius';
    }
  }

  /// low temperature as a string that can be passed to TTS
  String get sementicLow => '${numberFormat.format(low)} ${degrees(low)}';

  /// high temperature as a string that can be passed to TTS
  String get sementicHigh => '${numberFormat.format(high)} ${degrees(high)}';

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  /// Temperature with a better number format
  String get temperatureFormat => '${numberFormat.format(temperature)}$unitString';

  /// Low temperature with a better number format
  String get lowFormat => '${numberFormat.format(low)}$unitString';

  /// High temperature with a better number format
  String get highFormat => '${numberFormat.format(high)}$unitString';

  /// Capitalized weather string
  String get weatherFormat => _capitalize(weatherString);
}
