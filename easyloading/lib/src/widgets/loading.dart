import 'package:flutter/material.dart';

import '../easy_loading.dart';
import './overlay_entry.dart';

class FlutterEasyLoading extends StatefulWidget {
  final Widget? child;

  const FlutterEasyLoading({
    Key? key,
    required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  _FlutterEasyLoadingState createState() => _FlutterEasyLoadingState();
}

class _FlutterEasyLoadingState extends State<FlutterEasyLoading> {
  late EasyLoadingOverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = EasyLoadingOverlayEntry(
      builder: (BuildContext context) => EasyLoading.instance.w ?? Container(),
    );
    EasyLoading.instance.overlayEntry = _overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          EasyLoadingOverlayEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return Container();
              }
            },
          ),
          _overlayEntry,
        ],
      ),
    );
  }
}
