import 'package:flutter/material.dart';

/// Text animation where the current text pushes the previous text up to take
/// its place.
/// A fading gradient let the text appear and disappear smoothly
class AnimatedText extends StatefulWidget {
  const AnimatedText({
    Key? key,
    required this.current,
    this.previous,
    this.curve = Curves.linear,
    this.offset = 1,
    required this.duration,
  })  : assert(current != null),
        assert(curve != null),
        assert(duration != null),
        super(key: key);

  /// Current text to display
  final String current;

  /// The previous text. If not specified or equal to current,
  /// no animation occures
  final String? previous;

  /// The duration of the whole orchestrated animation.
  final Duration duration;

  /// The Animation curve
  final Curve curve;

  /// How fare the text will be pushed
  final double offset;

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animationOld;
  late Animation<Offset> _animationNew;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    if (widget.current != oldWidget.current) {
      _animationOld = Tween<Offset>(
        begin: Offset.zero,
        end: Offset(0, -widget.offset),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ));

      _animationNew = Tween<Offset>(
        begin: Offset(0, widget.offset),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ));

      _controller.forward(from: _controller.lowerBound);
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = Text(widget.current);

    if (_controller.isAnimating) {
      return ClipRect(
        child: ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
              stops: [0, .2, .8, 1],
            ).createShader(
              Rect.fromLTRB(0, 0, rect.width, rect.height),
            );
          },
          blendMode: BlendMode.dstIn,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SlideTransition(
                  position: _animationOld,
                  child: Text(widget.previous ?? ""),
                ),
                SlideTransition(
                  position: _animationNew,
                  child: current,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return current;
  }
}
