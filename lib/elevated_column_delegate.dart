part of 'elevated_flex.dart';

class _ElevatedColumnDelegate extends _ElevatedFlexDelegate {
  _ElevatedColumnDelegate({
    required super.mainAxisAlignment,
    required super.mainAxisSize,
    required super.crossAxisAlignment,
    required super.verticalDirection,
  }) : super(
          direction: Axis.vertical,
        );

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

  void positionChildren() {
    final startAndShift = calcStartYAndShift();

    double nextChildY = startAndShift.startY;

    // positioning children with order according elevation
    for (int i = 0; i < childrenCount; i++) {
      final child = getChild(i);

      // for column
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
    width = maxChildrenWidth;
  }

  void calcHeight() {
    height = (mainAxisSize == MainAxisSize.max) ? constraints.maxHeight : sumChildrenHeight;
  }
}
