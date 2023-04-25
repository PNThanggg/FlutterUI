import 'package:flutter/material.dart';

import 'flavor.dart';
import 'theme.dart';
import 'widgets/background/background.dart';
import 'widgets/clock.dart';
import 'widgets/shade_box.dart';
import 'widgets/weather.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final theme = ClockTheme.of(context);

        // Adapt the date and time dimensions to the available space
        final size = constraints.biggest.shortestSide / 4;

        // On a small screen we might need to scale out the weather box
        final scale = size <= 100 ? size / 100 : 1.0;

        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const Background(),
            RepaintBoundary(
              child: Padding(
                padding: EdgeInsets.all(size),
                child: const Clock(),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.topRight,
                  child: ShadeBox(
                    padding: const EdgeInsets.all(15),
                    color: theme.shadeBox,
                    fadeDuration: Flavor.of(context).weatherFadeDuration,
                    sizeDuration: Flavor.of(context).weatherSizeDuration,
                    child: const Weather(),
                  )),
            ),
          ],
        );
      },
    );
  }
}
