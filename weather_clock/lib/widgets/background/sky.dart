import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:spritewidget/spritewidget.dart';

/// The GradientNode performs custom drawing to draw a gradient background.
class GradientNode extends NodeWithSize {
  GradientNode(Size size, this.colors)
      : assert(colors != null),
        assert(colors.length == 2),
        super(size);

  List<Color> colors;

  @override
  void paint(Canvas canvas) {
    applyTransformForPivot(canvas);

    final rect = Offset.zero & size;
    final gradientPaint = Paint();

    gradientPaint.shader = LinearGradient(
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomLeft,
        colors: colors,
        stops: <double>[0.0, 1.0]).createShader(rect);

    canvas.drawRect(rect, gradientPaint);
  }
}
