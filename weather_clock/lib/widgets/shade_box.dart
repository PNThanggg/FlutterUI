// Copyright (c) 2020, David PHAM-VAN. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// Container Widget that gradually changes its color and dimensions
/// with different duration values
class ShadeBox extends ImplicitlyAnimatedWidget {
  const ShadeBox({
    Key key,
    @required this.child,
    this.padding,
    @required this.color,
    @required Duration fadeDuration,
    @required this.sizeDuration,
  })  : assert(child != null),
        assert(color != null),
        assert(sizeDuration != null),
        super(
          key: key,
          curve: Curves.linear,
          duration: fadeDuration,
        );

  final Widget child;

  final EdgeInsetsGeometry padding;

  final Color color;

  final Duration sizeDuration;

  @override
  _ShadeBoxState createState() => _ShadeBoxState();
}

class _ShadeBoxState extends AnimatedWidgetBaseState<ShadeBox>
    with TickerProviderStateMixin {
  ColorTween _colorTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _colorTween = visitor(_colorTween, widget.color,
        (dynamic value) => ColorTween(begin: value as Color)) as ColorTween;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: _colorTween.evaluate(animation),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: AnimatedSize(
          vsync: this,
          curve: Curves.elasticOut,
          duration: widget.sizeDuration,
          child: widget.child,
        ),
      ),
    );
  }
}
