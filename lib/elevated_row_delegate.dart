part of 'elevated_flex.dart';

class _ElevatedRowDelegate extends BoxyDelegate {
  _ElevatedRowDelegate({
    required this.mainAxisAlignment,
    required this.mainAxisSize,
    required this.crossAxisAlignment,
    required this.verticalDirection,
  });

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
        childConstraints = constraints.copyWith(minWidth: constraints.maxWidth);
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

    double nextChildY = startAndShift.startY;

    // positioning children with order according elevation
    for (int i = 0; i < childrenCount; i++) {
      final child = getChild(i);

      // for row
      final double x = switch (crossAxisAlignment) {
        CrossAxisAlignment.start || CrossAxisAlignment.stretch || CrossAxisAlignment.baseline => 0,
        CrossAxisAlignment.end => width - child.size.width,
        CrossAxisAlignment.center => (width - child.size.width) / 2,
      };
      final double y = nextChildY;
      final offset = Offset(x, y);

      child.position(offset);

      // calc y offset for next child
      nextChildY += child.size.height + startAndShift.stepShift;
    }
  }

  void calcWidth() {
    final childrenWidths = children.map((child) => child.size.width);
    final maxWidth = childrenWidths.max;
    width = maxWidth;
  }

  void calcHeight() {
    if (mainAxisSize == MainAxisSize.max) {
      height = constraints.maxHeight;
    } else {
      height = sumChildrenHeight;
    }
  }

  double get sumChildrenHeight {
    return children.fold(0.0, (sum, child) => sum + child.size.height);
  }
}
