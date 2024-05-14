part of 'elevated_flex.dart';

class _ElevatedFlexDelegate extends BoxyDelegate {
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;

  _ElevatedFlexDelegate({
    // super.relayout,
    // super.repaint,
    required this.direction,
    required this.mainAxisAlignment,
    required this.mainAxisSize,
    required this.crossAxisAlignment,
    required this.verticalDirection,
  });

  @override
  bool shouldRelayout(_ElevatedFlexDelegate oldDelegate) {
    return oldDelegate.direction != direction ||
        oldDelegate.mainAxisAlignment != mainAxisAlignment ||
        oldDelegate.mainAxisSize != mainAxisSize ||
        oldDelegate.crossAxisAlignment != crossAxisAlignment ||
        oldDelegate.verticalDirection != verticalDirection;
  }

  // inner calculation
  late final int childrenCount;
  late final double width;
  late final double height;

  MainAxisAlignment get effectiveMainAxisAlignment {
    // reverse mainAxisAlignment for up vertical direction
    if (isVertical && verticalDirection == VerticalDirection.up) {
      if (mainAxisAlignment == MainAxisAlignment.start) {
        return MainAxisAlignment.end;
      }
      if (mainAxisAlignment == MainAxisAlignment.end) {
        return MainAxisAlignment.start;
      }
    }

    return mainAxisAlignment;
  }

  CrossAxisAlignment get effectiveCrossAxisAlignment {
    // reverse crossAxisAlignment for up vertical direction
    if (isHorizontal && verticalDirection == VerticalDirection.up) {
      if (crossAxisAlignment == CrossAxisAlignment.start) {
        return CrossAxisAlignment.end;
      }
      if (crossAxisAlignment == CrossAxisAlignment.end) {
        return CrossAxisAlignment.start;
      }
    }
    return crossAxisAlignment;
  }

  @override
  Size layout() {
    // remember children count
    childrenCount = children.length;

    // layout children with order according elevation
    for (int i = 0; i < childrenCount; i++) {
      final child = getChild(i);
      BoxConstraints childConstraints = constraints;
      if (effectiveCrossAxisAlignment == CrossAxisAlignment.stretch) {
        if (isVertical) {
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

  void calcWidth() {
    if (isVertical) {
      width = maxChildrenWidth;
    } else {
      width = isMainAxisSizeMax ? constraints.maxWidth : sumChildrenWidth;
    }
  }

  void calcHeight() {
    if (isVertical) {
      height = isMainAxisSizeMax ? constraints.maxHeight : sumChildrenHeight;
    } else {
      height = maxChildrenHeight;
    }
  }

  /// positioning children with order according elevation
  void positionChildren() {
    if (isVertical) {

      // for column
      final startAndShift = calcStartYAndShift();
      double nextChildY = startAndShift.startY;

      for (int i = 0; i < childrenCount; i++) {
        final child = getChild(i);

        final double y = nextChildY;
        final double x = switch (effectiveCrossAxisAlignment) {
          CrossAxisAlignment.start || CrossAxisAlignment.stretch || CrossAxisAlignment.baseline => 0,
          CrossAxisAlignment.end => width - child.size.width,
          CrossAxisAlignment.center => (width - child.size.width) / 2,
        };

        child.position(Offset(x, y));

        // calc y offset for next child
        nextChildY += child.size.height + startAndShift.stepShift;
      }

    } else {

      // for row
      final startAndShift = calcStartXAndShift();
      double nextChildX = startAndShift.startX;

      for (int i = 0; i < childrenCount; i++) {
        final child = getChild(i);

        final double x = nextChildX;
        final double y = switch (effectiveCrossAxisAlignment) {
          CrossAxisAlignment.start || CrossAxisAlignment.stretch || CrossAxisAlignment.baseline => 0,
          CrossAxisAlignment.end => height - child.size.height,
          CrossAxisAlignment.center => (height - child.size.height) / 2,
        };

        child.position(Offset(x, y));

        // calc y offset for next child
        nextChildX += child.size.width + startAndShift.stepShift;
      }
    }
  }

  ({double startY, double stepShift}) calcStartYAndShift() {
    switch (mainAxisSize) {
      case MainAxisSize.min:
        return (startY: 0, stepShift: 0);

      case MainAxisSize.max:
        double freeSpaceHeight = constraints.maxHeight - sumChildrenHeight;

        return switch (effectiveMainAxisAlignment) {
          MainAxisAlignment.start => (startY: 0, stepShift: 0),

          // readability
          MainAxisAlignment.end => (startY: freeSpaceHeight, stepShift: 0),

          // readability
          MainAxisAlignment.center => (
              startY: freeSpaceHeight / 2,
              stepShift: 0,
            ),

          // readability
          MainAxisAlignment.spaceBetween => () {
              return (
                startY: 0.0,
                stepShift: freeSpaceHeight / (childrenCount - 1),
              );
            }(),

          // readability
          MainAxisAlignment.spaceAround => () {
              final spaceForChild = freeSpaceHeight / (childrenCount * 2);
              return (
                startY: spaceForChild,
                stepShift: spaceForChild * 2,
              );
            }(),

          // readability
          MainAxisAlignment.spaceEvenly => () {
              final spaceForChild = freeSpaceHeight / (childrenCount + 1);
              return (
                startY: spaceForChild,
                stepShift: spaceForChild,
              );
            }(),
        };
    }
  }

  ({double startX, double stepShift}) calcStartXAndShift() {
    switch (mainAxisSize) {
      case MainAxisSize.min:
        return (startX: 0, stepShift: 0);

      case MainAxisSize.max:
        double freeSpaceHeight = constraints.maxWidth - sumChildrenWidth;

        return switch (effectiveMainAxisAlignment) {
          MainAxisAlignment.start => (
              startX: 0,
              stepShift: 0,
            ),

          // readability
          MainAxisAlignment.end => (
              startX: freeSpaceHeight,
              stepShift: 0,
            ),

          // readability
          MainAxisAlignment.center => (
              startX: freeSpaceHeight / 2,
              stepShift: 0,
            ),

          // readability
          MainAxisAlignment.spaceBetween => (
              startX: 0,
              stepShift: freeSpaceHeight / (childrenCount - 1),
            ),

          // readability
          MainAxisAlignment.spaceAround => () {
              final spaceForChild = freeSpaceHeight / (childrenCount * 2);
              return (
                startX: spaceForChild,
                stepShift: spaceForChild * 2,
              );
            }(),

          // readability
          MainAxisAlignment.spaceEvenly => () {
              final spaceForChild = freeSpaceHeight / (childrenCount + 1);
              return (
                startX: spaceForChild,
                stepShift: spaceForChild,
              );
            }(),
        };
    }
  }

  bool get isVertical => direction == Axis.vertical;

  bool get isHorizontal => direction == Axis.horizontal;

  bool get isMainAxisSizeMax => mainAxisSize == MainAxisSize.max;

  double get sumChildrenWidth {
    return children.fold(0.0, (sum, child) => sum + child.size.width);
  }

  double get sumChildrenHeight {
    return children.fold(0.0, (sum, child) => sum + child.size.height);
  }

  double get maxChildrenWidth => children.map((child) => child.size.width).max;

  double get maxChildrenHeight => children.map((child) => child.size.height).max;
}
