// Copyright (c) 2020, David PHAM-VAN. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../flavor.dart';
import '../theme.dart';
import 'animated_push.dart';
import 'animated_text_style.dart';

/// Date and time Widget with animations
class Clock extends StatefulWidget {
  const Clock();

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String _clock;
  String _semanticClock;
  String _date;

  String _oldClock;
  String _oldDate;

  Timer _timer;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 60 - DateTime.now().second), () {
      updateClock();
      _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        updateClock();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(Clock oldWidget) {
    updateClock();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    updateClock();
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    updateClock();
    super.reassemble();
  }

  void updateClock() async {
    if (!mounted) return;

    final date = Flavor.of(context).getTime();
    final locale = Localizations.localeOf(context);

    // Returns immediately if already initialized
    await initializeDateFormatting(locale.languageCode);

    final newClock =
        Provider.of<ClockModel>(context, listen: false).is24HourFormat
            ? DateFormat.Hm(locale.languageCode).format(date)
            : DateFormat('h:mm', locale.languageCode).format(date);
    final newDate = DateFormat.yMMMMd(locale.languageCode).format(date);

    _semanticClock = DateFormat(
            Provider.of<ClockModel>(context, listen: false).is24HourFormat
                ? 'HH mm'
                : 'h mm a',
            locale.languageCode)
        .format(date);

    setState(() {
      _oldClock = _clock;
      _clock = newClock;
      _oldDate = _date;
      _date = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Need to listen to is24HourFormat
    Provider.of<ClockModel>(context);

    final theme = ClockTheme.of(context);

    return Semantics.fromProperties(
      excludeSemantics: true,
      properties: SemanticsProperties(
        value: 'Today is $_date. The current time is $_semanticClock',
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          children: <Widget>[
            if (_clock != null)
              AnimatedTextStyle(
                child: AnimatedText(
                  duration: Flavor.of(context).clockAnimateDuration,
                  current: _clock,
                  previous: _oldClock,
                ),
                style: theme.time,
                duration: Flavor.of(context).clockAnimateDuration,
              ),
            if (_date != null)
              AnimatedTextStyle(
                child: AnimatedText(
                  duration: Flavor.of(context).clockAnimateDuration,
                  current: _date,
                  previous: _oldDate,
                ),
                style: theme.date,
                duration: Flavor.of(context).clockAnimateDuration,
              ),
          ],
        ),
      ),
    );
  }
}
