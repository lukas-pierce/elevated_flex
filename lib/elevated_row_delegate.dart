part of 'elevated_flex.dart';

class _ElevatedRowDelegate extends _ElevatedFlexDelegate {
  _ElevatedRowDelegate({
    required super.mainAxisAlignment,
    required super.mainAxisSize,
    required super.crossAxisAlignment,
    required super.verticalDirection,
  }) : super(
          direction: Axis.horizontal,
        );

  @override
  Size layout() {
    // remember children count
    childrenCount = children.length;

    // layout children with order according elevation
    for (int i = 0; i < childrenCount; i++) {
      final child = getChild(i);
      BoxConstraints childConstraints = constraints;
      if (crossAxisAlignment == CrossAxisAlignment.stretch) {
        if (direction == Axis.vertical) {
          childConstraints = constraints.copyWith(minWidth: constraints.maxWidth);
        } else {
          childConstraints = constraints.copyWith(minHeight: constraints.maxHeight);
        }
      }
      child.layout(childConstraints);
    }

    calcWidth();
    calcHeight();
    positionChildren();

    return Size(width, height);
  }

  void positionChildren() {
    final startAndShift = calcStartXAndShift();

    double nextChildX = startAndShift.startX;

    // positioning children with order according elevation
    for (int i = 0; i < childrenCount; i++) {
      final child = getChild(i);

      // for row
      final double x = nextChildX;
      final double y = switch (crossAxisAlignment) {
        CrossAxisAlignment.start || CrossAxisAlignment.stretch || CrossAxisAlignment.baseline => 0,
        CrossAxisAlignment.end => height - child.size.height,
        CrossAxisAlignment.center => (height - child.size.height) / 2,
      };
      final offset = Offset(x, y);

      child.position(offset);

      // calc y offset for next child
      nextChildX += child.size.width + startAndShift.stepShift;
    }
  }

  void calcWidth() {
    if (direction == Axis.vertical) {
      width = maxChildrenWidth;
    } else {
      width = (mainAxisSize == MainAxisSize.max) ? constraints.maxWidth : sumChildrenWidth;
    }
  }

  void calcHeight() {
    if (direction == Axis.vertical) {
      height = (mainAxisSize == MainAxisSize.max) ? constraints.maxHeight : sumChildrenHeight;
    } else {
      height = maxChildrenHeight;
    }
  }
}
