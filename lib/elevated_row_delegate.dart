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
  void positionChildren() {
    final startAndShift = calcStartXAndShift();

    double nextChildMainCoord = startAndShift.startX;

    // positioning children with order according elevation
    for (int i = 0; i < childrenCount; i++) {
      final child = getChild(i);

      final double x, y;
      if (direction == Axis.vertical) {
        // for column
        x = switch (crossAxisAlignment) {
          CrossAxisAlignment.start || CrossAxisAlignment.stretch || CrossAxisAlignment.baseline => 0,
          CrossAxisAlignment.end => width - child.size.width,
          CrossAxisAlignment.center => (width - child.size.width) / 2,
        };
        y = nextChildY;
      } else {
        // for row
        x = nextChildMainCoord;
        y = switch (crossAxisAlignment) {
          CrossAxisAlignment.start || CrossAxisAlignment.stretch || CrossAxisAlignment.baseline => 0,
          CrossAxisAlignment.end => height - child.size.height,
          CrossAxisAlignment.center => (height - child.size.height) / 2,
        };
      }

      final offset = Offset(x, y);

      child.position(offset);

      // calc y offset for next child
      nextChildMainCoord += child.size.width + startAndShift.stepShift;
    }
  }
}
