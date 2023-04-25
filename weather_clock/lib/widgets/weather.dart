// Copyright (c) 2020, David PHAM-VAN. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:provider/provider.dart';

import '../flavor.dart';
import '../sementic_model.dart';
import '../theme.dart';

/// Top right weather information Widget
class Weather extends StatefulWidget {
  const Weather();

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ClockModel>(context);
    final theme = ClockTheme.of(context);

    return Semantics.fromProperties(
      excludeSemantics: true,
      properties: SemanticsProperties(
        value:
            'Currently in ${model.location}, it is ${model.sementicTemperature} with ${model.weatherFormat} weather, today you can expect a low of ${model.sementicLow} and a high of ${model.sementicHigh}',
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  AnimatedDefaultTextStyle(
                    child: Text(model.temperatureFormat),
                    style: theme.temperature,
                    duration: Flavor.of(context).weatherFadeDuration,
                  ),
                  const SizedBox(width: 10),
                  AnimatedDefaultTextStyle(
                    child: Text(
                        '${model.lowFormat} / ${model.highFormat}\n${model.weatherFormat}'),
                    style: theme.weather,
                    duration: Flavor.of(context).weatherFadeDuration,
                  ),
                ],
              ),
              AnimatedDefaultTextStyle(
                child: Text('${model.location}'),
                style: theme.weather,
                duration: Flavor.of(context).weatherFadeDuration,
              ),
            ],
          )
        ],
      ),
    );
  }
}
