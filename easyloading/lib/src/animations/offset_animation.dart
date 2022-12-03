import 'package:flutter/widgets.dart';

import 'animation.dart';

class OffsetAnimation extends EasyLoadingAnimation {
  OffsetAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    Offset begin = alignment == AlignmentDirectional.topCenter
        ? const Offset(0, -1)
        : alignment == AlignmentDirectional.bottomCenter
            ? const Offset(0, 1)
            : const Offset(0, 0);
    Animation<Offset> animation = Tween(
      begin: begin,
      end: const Offset(0, 0),
    ).animate(controller);
    return Opacity(
      opacity: controller.value,
      child: SlideTransition(
        position: animation,
        child: child,
      ),
    );
  }
}
