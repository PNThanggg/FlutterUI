part of spritewidget;

/// Labels are used to display a string of text in a the node tree. To align
/// the label, the textAlign property of the [TextStyle] can be set.
class Label extends Node {
  /// Creates a new Label with the provided [text] and [textStyle].
  Label(this._text, {TextStyle? textStyle, TextAlign? textAlign})
      : _textStyle = textStyle ?? const TextStyle(),
        textAlign = textAlign ?? TextAlign.left;

  /// The text being drawn by the label.
  String get text => _text;
  String _text;
  set text(String text) {
    _text = text;
    _painter = null;
  }

  /// The style to draw the text in.
  TextStyle get textStyle => _textStyle;
  TextStyle _textStyle;
  set textStyle(TextStyle textStyle) {
    _textStyle = textStyle;
    _painter = null;
  }

  /// How the text should be aligned horizontally.
  TextAlign textAlign;

  TextPainter? _painter;
  late double _width;

  @override
  void paint(Canvas canvas) {
    if (_painter == null) {
      _painter = TextPainter(
        text: TextSpan(style: _textStyle, text: _text),
        textDirection: TextDirection.ltr,
      )..layout();
      _width = _painter!.size.width;
    }

    Offset offset = Offset.zero;
    if (textAlign == TextAlign.center) {
      offset = Offset(-_width / 2.0, 0.0);
    } else if (textAlign == TextAlign.right) {
      offset = Offset(-_width, 0.0);
    }

    _painter!.paint(canvas, offset);
  }
}
