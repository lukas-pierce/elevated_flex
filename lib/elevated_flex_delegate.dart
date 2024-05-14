part of 'elevated_flex.dart';

abstract class _ElevatedFlexDelegate extends BoxyDelegate {
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

  double get sumChildrenWidth => children.fold(0.0, (sum, child) => sum + child.size.width);

  double get sumChildrenHeight => children.fold(0.0, (sum, child) => sum + child.size.height);

  double get maxChildrenWidth => children.map((child) => child.size.width).max;

  double get maxChildrenHeight => children.map((child) => child.size.height).max;

  MainAxisAlignment get effectiveMainAxisAlignment {
    // reverse mainAxisAlignment for up vertical direction
    if (direction == Axis.vertical && verticalDirection == VerticalDirection.up) {
      if (mainAxisAlignment == MainAxisAlignment.start) return MainAxisAlignment.end;
      if (mainAxisAlignment == MainAxisAlignment.end) return MainAxisAlignment.start;
    }

    return mainAxisAlignment;
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
          MainAxisAlignment.center => (startY: freeSpaceHeight / 2, stepShift: 0),

        // readability
          MainAxisAlignment.spaceBetween => (startY: 0, stepShift: freeSpaceHeight / (childrenCount - 1)),

        // readability
          MainAxisAlignment.spaceAround => () {
            final spaceForChild = freeSpaceHeight / (childrenCount * 2);
            return (startY: spaceForChild, stepShift: spaceForChild * 2);
          }(),

        // readability
          MainAxisAlignment.spaceEvenly => () {
            final spaceForChild = freeSpaceHeight / (childrenCount + 1);
            return (startY: spaceForChild, stepShift: spaceForChild);
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
