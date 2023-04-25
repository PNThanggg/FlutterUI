part of spritewidget;

/// A NineSliceSprite is similar to a [Sprite], but it it can strech its
/// inner area to fit the size of the [Node]. This is ideal for fast drawing
/// of things like buttons.
class NineSliceSprite extends NodeWithSize with SpritePaint {
  /// Creates a new NineSliceSprite from the privided [texture], [size], and
  /// texture [insets].
  NineSliceSprite({
    required SpriteTexture texture,
    required Size size,
    required EdgeInsets insets,
  }) : super(size) {
    assert(!texture.rotated);
    pivot = const Offset(0.5, 0.5);
    this.texture = texture;
    this.insets = insets;
  }

  /// Creates a new NineSliceSprite from the provided [image], [size], and
  /// texture [insets].
  NineSliceSprite.fromImage({
    required ui.Image image,
    required Size size,
    required insets,
  }) : this(
          texture: SpriteTexture(image),
          size: size,
          insets: insets,
        );

  /// The texture that the sprite will render to screen. Cannot be null.
  ///
  ///     my9Sprite.texture = myTexture;
  SpriteTexture get texture => _texture;

  late SpriteTexture _texture;

  set texture(SpriteTexture texture) {
    _texture = texture;
    _isDirty = true;
    Matrix4 matrix = Matrix4.identity();
    ImageShader shader = ImageShader(
        texture.image, TileMode.repeated, TileMode.repeated, matrix.storage);

    _cachedPaint = Paint()..shader = shader;
  }

  /// The insets of the texture as normalized values. The insets define the
  /// areas of the texture that will not be deformed as the sprite stretches.
  EdgeInsets get insets => _insets;

  late EdgeInsets _insets;

  set insets(EdgeInsets insets) {
    _insets = insets;
    _isDirty = true;
  }

  /// If true, the center part of the sprite will be drawn, this is the default
  /// behavior.
  bool get drawCenterPart => _drawCenterPart;

  bool _drawCenterPart = true;

  set drawCenterPart(bool drawCenterPart) {
    _drawCenterPart = drawCenterPart;
    _isDirty = true;
  }

  @override
  set size(Size size) {
    super.size = size;
    _isDirty = true;
  }

  Paint _cachedPaint = Paint()
    ..filterQuality = FilterQuality.low
    ..isAntiAlias = false;

  // Cached values.
  bool _isDirty = true;
  late List<Offset> _vertices;
  late List<Offset> _textureCoordinates;
  late List<Color> _colors;
  late List<int> _indices;

  @override
  void paint(Canvas canvas) {
    applyTransformForPivot(canvas);

    // Setup paint object for opacity and transfer mode.
    _updatePaint(_cachedPaint);

    if (_isDirty) {
      // Calcuate vertices and indices.
      _vertices = <Offset>[
        Offset.zero,
      ];

      // Texture width and height.
      double tw = texture.frame.width;
      double th = texture.frame.height;
      _textureCoordinates = <Offset>[];
      _vertices = <Offset>[];
      _colors = <Color>[];

      for (int y = 0; y < 4; y += 1) {
        late double vy;
        late double ty;

        switch (y) {
          case 0:
            vy = 0.0;
            ty = texture.frame.top;
            break;
          case 1:
            vy = insets.top * th;
            ty = texture.frame.top + insets.top * th;
            break;
          case 2:
            vy = size.height - insets.bottom * th;
            ty = texture.frame.bottom - insets.bottom * th;
            break;
          case 3:
            vy = size.height;
            ty = texture.frame.bottom;
            break;
        }

        for (int x = 0; x < 4; x += 1) {
          late double vx;
          late double tx;

          switch (x) {
            case 0:
              vx = 0.0;
              tx = texture.frame.left;
              break;
            case 1:
              vx = insets.left * tw;
              tx = texture.frame.left + insets.left * tw;
              break;
            case 2:
              vx = size.width - insets.right * tw;
              tx = texture.frame.right - insets.right * tw;
              break;
            case 3:
              vx = size.width;
              tx = texture.frame.right;
              break;
          }

          _vertices.add(Offset(vx, vy));
          _textureCoordinates.add(Offset(tx, ty));
          _colors.add(const Color(0xffffffff));
        }
      }

      // Build indices.
      _indices = <int>[];
      for (int y = 0; y < 3; y += 1) {
        for (int x = 0; x < 3; x += 1) {
          // Check if we should skip the middle rectangle.
          if (!drawCenterPart && x == 1 && y == 1) continue;

          // Add a rectangle (two triangles).
          int index = y * 4 + x;

          _indices.add(index);
          _indices.add(index + 1);
          _indices.add(index + 4);

          _indices.add(index + 1);
          _indices.add(index + 5);
          _indices.add(index + 4);
        }
      }
    }

    // TODO: Fix
//    canvas.drawVertices(
//      VertexMode.triangles,
//      _vertices,
//      _textureCoordinates,
//      _colors,
//        BlendMode.modulate,
//      _indices,
//      _cachedPaint
//    );
  }
}
