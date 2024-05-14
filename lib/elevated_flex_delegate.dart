part of 'elevated_flex.dart';

abstract class _ElevatedFlexDelegate extends BoxyDelegate {
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;

  _ElevatedFlexDelegate({
    super.relayout,
    super.repaint,
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

  double get sumChildrenWidth {
    return children.fold(0.0, (sum, child) => sum + child.size.width);
  }

  double get sumChildrenHeight {
    return children.fold(0.0, (sum, child) => sum + child.size.height);
  }

  double get maxChildrenWidth {
    return children.map((child) => child.size.width).max;
  }

  double get maxChildrenHeight {
    return children.map((child) => child.size.height).max;
  }

  MainAxisAlignment get effectiveMainAxisAlignment {
    // reverse mainAxisAlignment for up vertical direction
    if (direction == Axis.vertical && verticalDirection == VerticalDirection.up) {
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
}
