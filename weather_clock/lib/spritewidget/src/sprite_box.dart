part of spritewidget;

/// Options for setting up a [SpriteBox]'s coordinate system.
enum SpriteBoxTransformMode {
  /// Use the same points as the parent [Widget].
  nativePoints,

  /// Use the size of the root node for the coordinate system, and constrain the
  /// aspect ratio and trim off areas that end up outside the screen.
  letterbox,

  /// Use the size of the root node for the coordinate system, and scale it to
  /// fit the size of the box.
  stretch,

  /// Similar to the letterbox option, but instead of trimming areas the sprite
  /// system will be scaled down to fit the box.
  scaleToFit,

  /// Use the width of the root node to set the size of the coordinate system,
  /// and change the height of the root node to fit the box.
  fixedWidth,

  /// Use the height of the root node to set the size of the coordinate system,
  /// and change the width of the root node to fit the box.
  fixedHeight,
}

/// A [RenderBox] that draws a sprite world represented by a [Node] tree.
class SpriteBox extends RenderBox {
  // Setup

  /// Creates a new SpriteBox with a node as its content, by default uses
  /// letterboxing.
  ///
  /// The [rootNode] provides the content of the node tree, typically it's a
  /// custom subclass of [NodeWithSize]. The [transformMode] provides different ways to
  /// scale the content to best fit it to the screen. In most cases it's
  /// preferred to use a [SpriteWidget] that automatically wraps the SpriteBox.
  ///
  ///     var spriteBox = SpriteBox(myNode, SpriteBoxTransformMode.fixedHeight);
  SpriteBox({
    required NodeWithSize rootNode,
    SpriteBoxTransformMode transformMode = SpriteBoxTransformMode.letterbox,
  }) {
    // Setup transform mode
    _transformMode = transformMode;
    // this.transformMode = mode;

    // Setup root node
    _rootNode = rootNode;
    _addSpriteBoxReference(_rootNode);
  }

  void _removeSpriteBoxReference(Node node) {
    node._spriteBox = null;
    for (Node child in node._children) {
      _removeSpriteBoxReference(child);
    }
  }

  void _addSpriteBoxReference(Node node) {
    node._spriteBox = this;
    for (Node child in node._children) {
      _addSpriteBoxReference(child);
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _scheduleTick();
    _attachKeyboard();
  }

  @override
  void detach() {
    super.detach();
    _unscheduleTick();
    _detachKeyboard();
  }

  // Member variables

  // Tracking of frame rate and updates
  Duration? _lastTimeStamp;
  double _frameRate = 0.0;

  /// An instantaneous estimate of the number of frames per second this sprite
  /// box is producing.
  double get frameRate => _frameRate;

  // Transformation mode
  late SpriteBoxTransformMode _transformMode;

  set transformMode(SpriteBoxTransformMode value) {
    if (value == _transformMode) return;
    _transformMode = value;

    // Invalidate stuff
    markNeedsLayout();
  }

  /// The transform mode used by the [SpriteBox].
  SpriteBoxTransformMode get transformMode => _transformMode;

  // Cached transformation matrix
  Matrix4? _transformMatrix;

  List<Node>? _eventTargets;

  List<MotionController?>? _motionControllers;

  List<Node>? _constrainedNodes;

  /// A rectangle that represents the visible area of the sprite world's
  /// coordinate system.
  Rect? get visibleArea {
    if (_visibleArea == null) _calcTransformMatrix();
    return _visibleArea;
  }

  Rect? _visibleArea;

  bool _initialized = false;

  // Properties

  /// The root node of the node tree that is rendered by this box.
  ///
  ///     var rootNode = mySpriteBox.rootNode;
  NodeWithSize get rootNode => _rootNode;

  late NodeWithSize _rootNode;

  set rootNode(NodeWithSize value) {
    if (value == _rootNode) return;

    // Ensure that the root node has a size
    assert(_transformMode == SpriteBoxTransformMode.nativePoints ||
        value.size.width > 0);
    assert(_transformMode == SpriteBoxTransformMode.nativePoints ||
        value.size.height > 0);

    // Remove sprite box references
    _removeSpriteBoxReference(_rootNode);

    // Update the value
    _rootNode = value;
    _motionControllers = null;

    // Add new references
    _addSpriteBoxReference(_rootNode);
    markNeedsLayout();
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    _invalidateTransformMatrix();
    _initialized = true;
  }

  // Adding and removing nodes

  void _registerNode(Node node) {
    _motionControllers = null;
    _eventTargets = null;
    if (node.constraints != null) _constrainedNodes = null;
  }

  void _deregisterNode(Node? node) {
    _motionControllers = null;
    _eventTargets = null;
    if (node == null || node.constraints != null) _constrainedNodes = null;
  }

  void _addEventTargets([Node? node]) {
    _eventTargets ??= <Node>[];
    node ??= _rootNode;

    List<Node> children = node.children;
    int i = 0;

    // Add childrens that are behind this node
    while (i < children.length) {
      Node child = children[i];
      if (child.zPosition >= 0.0) break;
      _addEventTargets(child);
      i++;
    }

    // Add this node
    if (node.userInteractionEnabled) {
      _eventTargets!.add(node);
    }

    // Add children in front of this node
    while (i < children.length) {
      Node child = children[i];
      _addEventTargets(child);
      i++;
    }
  }

  bool _keyboardAttached = false;

  void _attachKeyboard() {
    assert(!_keyboardAttached);
    HardwareKeyboard.instance.addHandler(_handleKeyboardEvent);
    _keyboardAttached = true;
  }

  void _detachKeyboard() {
    HardwareKeyboard.instance.removeHandler(_handleKeyboardEvent);
    _keyboardAttached = false;
  }

  bool _handleKeyboardEvent(KeyEvent event) {
    if (!attached) return false;

    _addEventTargets();
    bool consumed = false;
    for (final node in _eventTargets!) {
      consumed = node.handleKeyboardEvent(event);
      if (consumed) {
        break;
      }
    }

    return consumed;
  }

  @override
  void handleEvent(PointerEvent event, _SpriteBoxHitTestEntry entry) {
    if (!attached) return;

    if (event is PointerDownEvent) {
      // Build list of event targets
      _addEventTargets();

      // Find the once that are hit by the pointer
      List<Node> nodeTargets = <Node>[];
      for (int i = _eventTargets!.length - 1; i >= 0; i--) {
        Node node = _eventTargets![i];

        // Check if the node is ready to handle a pointer
        if (node.handleMultiplePointers || node._handlingPointer == null) {
          // Do the hit test
          Offset posInNodeSpace =
              node.convertPointToNodeSpace(entry.localPosition);
          if (node.isPointInside(posInNodeSpace)) {
            nodeTargets.add(node);
            node._handlingPointer = event.pointer;
          }
        }
      }

      entry.nodeTargets = nodeTargets;
    }

    // Pass the event down to nodes that were hit by the pointerdown
    List<Node> targets = entry.nodeTargets;
    for (Node node in targets) {
      // Check if this event should be dispatched
      if (node.handleMultiplePointers ||
          event.pointer == node._handlingPointer) {
        // Dispatch event
        bool consumedEvent = node.handleEvent(
          SpriteBoxEvent(
            globalToLocal(event.position),
            _eventToEventType(event),
            event.pointer,
          ),
        );
        if (consumedEvent) break;
      }
    }

    // De-register pointer for nodes that doesn't handle multiple pointers
    for (Node node in targets) {
      if (event is PointerUpEvent || event is PointerCancelEvent) {
        node._handlingPointer = null;
      }
    }
  }

  @override
  bool hitTest(HitTestResult result, {required Offset position}) {
    result.add(_SpriteBoxHitTestEntry(this, position));
    return true;
  }

  // Rendering

  /// The transformation matrix used to transform the root node to the space of
  /// the box.
  ///
  /// It's uncommon to need access to this property.
  ///
  ///     var matrix = mySpriteBox.transformMatrix;
  Matrix4 get transformMatrix {
    // Get cached matrix if available
    if (_transformMatrix == null) {
      _calcTransformMatrix();
    }
    return _transformMatrix!;
  }

  void _calcTransformMatrix() {
    _transformMatrix = Matrix4.identity();

    // Calculate matrix
    double scaleX = 1.0;
    double scaleY = 1.0;
    double offsetX = 0.0;
    double offsetY = 0.0;

    double systemWidth = rootNode.size.width;
    double systemHeight = rootNode.size.height;

    switch (_transformMode) {
      case SpriteBoxTransformMode.stretch:
        scaleX = size.width / systemWidth;
        scaleY = size.height / systemHeight;
        break;
      case SpriteBoxTransformMode.letterbox:
        scaleX = size.width / systemWidth;
        scaleY = size.height / systemHeight;
        if (scaleX > scaleY) {
          scaleY = scaleX;
          offsetY = (size.height - scaleY * systemHeight) / 2.0;
        } else {
          scaleX = scaleY;
          offsetX = (size.width - scaleX * systemWidth) / 2.0;
        }
        break;
      case SpriteBoxTransformMode.scaleToFit:
        scaleX = size.width / systemWidth;
        scaleY = size.height / systemHeight;
        if (scaleX < scaleY) {
          scaleY = scaleX;
          offsetY = (size.height - scaleY * systemHeight) / 2.0;
        } else {
          scaleX = scaleY;
          offsetX = (size.width - scaleX * systemWidth) / 2.0;
        }
        break;
      case SpriteBoxTransformMode.fixedWidth:
        scaleX = size.width / systemWidth;
        scaleY = scaleX;
        systemHeight = size.height / scaleX;
        rootNode.size = Size(systemWidth, systemHeight);
        break;
      case SpriteBoxTransformMode.fixedHeight:
        scaleY = size.height / systemHeight;
        scaleX = scaleY;
        systemWidth = size.width / scaleY;
        rootNode.size = Size(systemWidth, systemHeight);
        break;
      case SpriteBoxTransformMode.nativePoints:
        systemWidth = size.width;
        systemHeight = size.height;
        break;
      default:
        assert(false);
        break;
    }

    _visibleArea = Rect.fromLTRB(-offsetX / scaleX, -offsetY / scaleY,
        systemWidth + offsetX / scaleX, systemHeight + offsetY / scaleY);

    _transformMatrix!.translate(offsetX, offsetY);
    _transformMatrix!.scale(scaleX, scaleY);

    _callSpriteBoxPerformedLayout(rootNode);
  }

  void _invalidateTransformMatrix() {
    _visibleArea = null;
    _transformMatrix = null;
    _rootNode._invalidateToBoxTransformMatrix();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    // Move to correct coordinate space before drawing
    canvas
      ..save()
      ..translate(offset.dx, offset.dy)
      ..transform(transformMatrix.storage);

    // Draw the sprite tree
    _rootNode._visit(canvas);

    canvas.restore();
  }

  // Updates

  late int _frameCallbackId;

  void _scheduleTick() {
    _frameCallbackId = SchedulerBinding.instance.scheduleFrameCallback(_tick);
  }

  void _unscheduleTick() {
    SchedulerBinding.instance.cancelFrameCallbackWithId(_frameCallbackId);
  }

  void _tick(Duration timeStamp) {
    if (!attached) return;

    // Calculate delta and frame rate
    _lastTimeStamp ??= timeStamp;
    double delta = (timeStamp - _lastTimeStamp!).inMicroseconds.toDouble() /
        Duration.microsecondsPerSecond;
    _lastTimeStamp = timeStamp;

    _frameRate = 1.0 / delta;

    if (_initialized) {
      _callConstraintsPreUpdate(delta);
      _runActions(delta);
      _callUpdate(_rootNode, delta);
      _callConstraintsConstrain(delta);
    }

    // Schedule next update
    _scheduleTick();

    // Make sure the node graph is redrawn
    markNeedsPaint();
  }

  void _runActions(double dt) {
    if (_motionControllers == null) {
      _rebuildActionControllersAndPhysicsNodes();
    }
    for (MotionController? actions in _motionControllers!) {
      actions!.step(dt);
    }
  }

  void _rebuildActionControllersAndPhysicsNodes() {
    _motionControllers = <MotionController?>[];
    _addActionControllersAndPhysicsNodes(_rootNode);
  }

  void _addActionControllersAndPhysicsNodes(Node node) {
    if (node._motions != null) _motionControllers!.add(node._motions);

    for (int i = node.children.length - 1; i >= 0; i--) {
      Node child = node.children[i];
      _addActionControllersAndPhysicsNodes(child);
    }
  }

  void _callUpdate(Node node, double dt) {
    node.update(dt);
    for (int i = node.children.length - 1; i >= 0; i--) {
      Node child = node.children[i];
      if (!child.paused) {
        _callUpdate(child, dt);
      }
    }
  }

  void _callConstraintsPreUpdate(double dt) {
    if (_constrainedNodes == null) {
      _constrainedNodes = <Node>[];
      _addConstrainedNodes(_rootNode, _constrainedNodes);
    }

    for (Node node in _constrainedNodes!) {
      for (Constraint constraint in node.constraints!) {
        constraint.preUpdate(node, dt);
      }
    }
  }

  void _callConstraintsConstrain(double dt) {
    if (_constrainedNodes == null) {
      _constrainedNodes = <Node>[];
      _addConstrainedNodes(_rootNode, _constrainedNodes);
    }

    for (Node node in _constrainedNodes!) {
      for (Constraint constraint in node.constraints!) {
        constraint.constrain(node, dt);
      }
    }
  }

  void _addConstrainedNodes(Node node, List<Node>? nodes) {
    if (node._constraints != null && node._constraints!.isNotEmpty) {
      nodes!.add(node);
    }

    for (Node child in node.children) {
      _addConstrainedNodes(child, nodes);
    }
  }

  void _callSpriteBoxPerformedLayout(Node node) {
    node.spriteBoxPerformedLayout();
    for (Node child in node.children) {
      _callSpriteBoxPerformedLayout(child);
    }
  }

  // Hit tests

  /// Finds all nodes at a position defined in the box's coordinates.
  ///
  /// Use this method with caution. It searches the complete node tree to locate
  /// the nodes, which can be slow if the node tree is large.
  ///
  ///     List nodes = mySpriteBox.findNodesAtPosition(new Point(50.0, 50.0));
  List<Node> findNodesAtPosition(Offset position) {
    List<Node> nodes = <Node>[];

    // Traverse the render tree and find objects at the position
    _addNodesAtPosition(_rootNode, position, nodes);

    return nodes;
  }

  void _addNodesAtPosition(Node node, Offset position, List<Node> list) {
    // Visit children first
    for (Node child in node.children) {
      _addNodesAtPosition(child, position, list);
    }
    // Do the hit test
    Offset posInNodeSpace = node.convertPointToNodeSpace(position);
    if (node.isPointInside(posInNodeSpace)) {
      list.add(node);
    }
  }
}

class _SpriteBoxHitTestEntry extends BoxHitTestEntry {
  List<Node> nodeTargets = [];
  _SpriteBoxHitTestEntry(RenderBox target, Offset localPosition)
      : super(target, localPosition);
}

/// An event that is passed down the node tree when pointer events occur. The
/// SpriteBoxEvent is typically handled in the handleEvent method of [Node].
class SpriteBoxEvent {
  /// The position of the event in box coordinates.
  ///
  /// You can use the convertPointToNodeSpace of [Node] to convert the position
  /// to local coordinates.
  ///
  ///     bool handleEvent(SpriteBoxEvent event) {
  ///       Point localPosition = convertPointToNodeSpace(event.boxPosition);
  ///       if (event.type == PointerEventType.down) {
  ///         // Do something!
  ///       }
  ///     }
  final Offset boxPosition;

  /// The type of event, there are currently four valid types, PointerDownEvent,
  /// PointerMoveEvent, PointerUpEvent, and PointerCancelEvent.
  ///
  ///     if (event.type == PointerEventType.down) {
  ///       // Do something!
  ///     }
  final PointerEventType type;

  /// The id of the pointer. Each pointer on the screen will have a unique
  /// pointer id.
  ///
  ///     if (event.pointer == firstPointerId) {
  ///       // Do something
  ///     }
  final int pointer;

  /// Creates a new SpriteBoxEvent, typically this is done internally inside the
  /// SpriteBox.
  ///
  ///     var event = new SpriteBoxEvent(new Point(50.0, 50.0), 'pointerdown', 0);
  SpriteBoxEvent(this.boxPosition, this.type, this.pointer);
}

/// Defines types for pointer events.
enum PointerEventType {
  /// A pointer was down.
  down,

  /// A pointer was moved.
  move,

  /// A pointer was released.
  up,

  /// A pointer was cancelled.
  cancel,
}

PointerEventType _eventToEventType(PointerEvent event) {
  if (event is PointerDownEvent) {
    return PointerEventType.down;
  } else if (event is PointerMoveEvent) {
    return PointerEventType.move;
  } else if (event is PointerUpEvent) {
    return PointerEventType.up;
  } else if (event is PointerCancelEvent) {
    return PointerEventType.cancel;
  } else {
    throw Exception('Illegal event type $event');
  }
}
