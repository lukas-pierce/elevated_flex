part of 'elevated_flex.dart';

class _ElevatedRowDelegate extends _ElevatedFlexDelegate {
  _ElevatedRowDelegate({
    required this.mainAxisAlignment,
    required this.mainAxisSize,
    required this.crossAxisAlignment,
    required this.verticalDirection,
  }) : super(
          direction: Axis.horizontal,
        );

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;

  // inner calculation
  late final int childrenCount;
  late final double width;
  late final double height;

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

  MainAxisAlignment get effectiveMainAxisAlignment {
    // reverse mainAxisAlignment for up vertical direction
    if (verticalDirection == VerticalDirection.up) {
      if (mainAxisAlignment == MainAxisAlignment.start) return MainAxisAlignment.end;
      if (mainAxisAlignment == MainAxisAlignment.end) return MainAxisAlignment.start;
    }

    return mainAxisAlignment;
  }

  ({double startX, double stepShift}) calcStartXAndShift() {
    switch (mainAxisSize) {
      case MainAxisSize.min:
        return (startX: 0, stepShift: 0);

      case MainAxisSize.max:
        double freeSpaceHeight = constraints.maxHeight - sumChildrenHeight;

        return switch (effectiveMainAxisAlignment) {
          MainAxisAlignment.start => (startX: 0, stepShift: 0),

          // readability
          MainAxisAlignment.end => (startX: freeSpaceHeight, stepShift: 0),

          // readability
          MainAxisAlignment.center => (startX: freeSpaceHeight / 2, stepShift: 0),

          // readability
          MainAxisAlignment.spaceBetween => (startX: 0, stepShift: freeSpaceHeight / (childrenCount - 1)),

          // readability
          MainAxisAlignment.spaceAround => () {
              final spaceForChild = freeSpaceHeight / (childrenCount * 2);
              return (startX: spaceForChild, stepShift: spaceForChild * 2);
            }(),

          // readability
          MainAxisAlignment.spaceEvenly => () {
              final spaceForChild = freeSpaceHeight / (childrenCount + 1);
              return (startX: spaceForChild, stepShift: spaceForChild);
            }(),
        };
    }
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
