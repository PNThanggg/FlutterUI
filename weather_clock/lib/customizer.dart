import 'package:flutter/material.dart';

import 'model.dart';

typedef ClockBuilder = Widget Function(ClockModel model);

class ClockCustomizer extends StatefulWidget {
  const ClockCustomizer(this._clock, {super.key});

  final ClockBuilder _clock;

  @override
  _ClockCustomizerState createState() => _ClockCustomizerState();
}

class _ClockCustomizerState extends State<ClockCustomizer> {
  final _model = ClockModel();
  ThemeMode _themeMode = ThemeMode.light;
  bool _configButtonShown = false;

  @override
  void initState() {
    super.initState();
    _model.addListener(_handleModelChange);
  }

  @override
  void dispose() {
    _model.removeListener(_handleModelChange);
    _model.dispose();
    super.dispose();
  }

  void _handleModelChange() => setState(() {});

  Widget _enumMenu<T>(String label, T value, List<T> items, ValueChanged<T?>? onChanged) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isDense: true,
          onChanged: onChanged,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(enumToString(item!)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _switch(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(label)),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _textField(String currentValue, String label, ValueChanged<String> onChanged) {
    return TextField(
      decoration: InputDecoration(
        hintText: currentValue,
        helperText: label,
      ),
      onChanged: onChanged,
    );
  }

  Widget _configDrawer(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _textField(_model.location, 'Location', (String location) {
                  setState(() {
                    _model.location = location;
                  });
                }),
                _textField(_model.temperature.toString(), 'Temperature', (String temperature) {
                  setState(() {
                    _model.temperature = double.parse(temperature);
                  });
                }),
                _enumMenu('Theme', _themeMode, ThemeMode.values.toList()..remove(ThemeMode.system), (ThemeMode? mode) {
                  setState(() {
                    _themeMode = mode!;
                  });
                }),
                _switch('24-hour format', _model.is24HourFormat, (bool value) {
                  setState(() {
                    _model.is24HourFormat = value;
                  });
                }),
                _enumMenu('Weather', _model.weatherCondition, WeatherCondition.values, (WeatherCondition? condition) {
                  setState(() {
                    _model.weatherCondition = condition!;
                  });
                }),
                _enumMenu('Units', _model.unit, TemperatureUnit.values, (TemperatureUnit? unit) {
                  setState(() {
                    _model.unit = unit!;
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _configButton() {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Configure clock',
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
            setState(() {
              _configButtonShown = false;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final clock = Center(
      child: AspectRatio(
        aspectRatio: 5 / 3,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).unselectedWidgetColor,
            ),
          ),
          child: widget._clock(_model),
        ),
      ),
    );

    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        endDrawer: _configDrawer(context),
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                _configButtonShown = !_configButtonShown;
              });
            },
            child: Stack(
              children: [
                clock,
                if (_configButtonShown)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Opacity(
                      opacity: 0.7,
                      child: _configButton(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
