import 'package:flutter/material.dart';

import '../../provider/provider.dart';
import 'controller/knob_controller.dart';
import 'utils/knob_style.dart';
import 'widgets/control_knob_container.dart';

class Knob extends StatelessWidget {
  final double? width;
  final double? height;
  final bool? enable;
  final KnobStyle? style;
  final KnobController? controller;

  const Knob({
    Key? key,
    this.width = 200,
    this.height = 200,
    this.enable = true,
    this.controller,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<KnobController>.value(
          value: controller ?? KnobController(),
        ),
        Provider.value(
          value: style ?? const KnobStyle(),
        ),
      ],
      child: ChangeNotifierProvider<KnobController>.value(
        value: controller ?? KnobController(),
        child: IgnorePointer(
          ignoring: !(enable ?? true),
          child: ControlKnobContainer(
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}
