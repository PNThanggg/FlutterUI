import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flavor.dart';
import 'interaction.dart';
import 'model.dart';
import 'screen.dart';

void main() {
  // Temporary macOS support
  if (!kIsWeb && Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  runApp(
    Flavor(
      data: FlavorData(
        isInteractive: true,
        isDemo: false,
        timeOffset:
            DateTime.now().difference(DateTime(2020, 1, 20, 23, 58, 30)),
      ),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _model = ClockModel();

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

  @override
  Widget build(BuildContext context) {
    Widget child = const Screen();

    if (Flavor.of(context).isInteractive) {
      // Inject the user interaction for debug build
      child = ClockInteraction(child: child);
    }

    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider.value(
          value: _model,
          child: child,
        ),
      ),
    );
  }
}
