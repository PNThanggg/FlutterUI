// Copyright (c) 2020, David PHAM-VAN. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

/// Amimate the text color and shadow color of its child.
/// This widget assumes a shadow defined in the current style
class AnimatedTextStyle extends ImplicitlyAnimatedWidget {
  const AnimatedTextStyle({
    Key key,
    @required this.child,
    @required this.style,
    Curve curve = Curves.linear,
    @required Duration duration,
  })  : assert(style != null),
        assert(child != null),
        super(key: key, curve: curve, duration: duration);

  final Widget child;

  final TextStyle style;

  @override
  _AnimatedTextStyleState createState() => _AnimatedTextStyleState();
}

class _TextStyleTween extends Tween<TextStyle> {
  _TextStyleTween({TextStyle begin, TextStyle end})
      : super(begin: begin, end: end);

  @override
  TextStyle lerp(double t) => begin.copyWith(
        color: Color.lerp(begin.color, end.color, t),
        shadows: <Shadow>[
          Shadow(
            blurRadius: ui.lerpDouble(
              begin.shadows[0].blurRadius,
              end.shadows[0].blurRadius,
              t,
            ),
            color: Color.lerp(
              begin.shadows[0].color,
              end.shadows[0].color,
              t,
            ),
          ),
        ],
      );
}

class _AnimatedTextStyleState
    extends AnimatedWidgetBaseState<AnimatedTextStyle> {
  _TextStyleTween _style;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _style = visitor(_style, widget.style,
            (dynamic value) => _TextStyleTween(begin: value as TextStyle))
        as _TextStyleTween;
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.style.shadows != null && widget.style.shadows.isNotEmpty,
      'AnimatedTextStyle requires a text style with a shadow',
    );

    return DefaultTextStyle(
      style: _style.evaluate(animation),
      child: widget.child,
    );
  }
}
