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

    double nextChildX = startAndShift.startX;

    // positioning children with order according elevation
    for (int i = 0; i < childrenCount; i++) {
      final child = getChild(i);

      final double x, y;
      if (direction == Axis.vertical) {
        // for column
        final double x = switch (crossAxisAlignment) {
          CrossAxisAlignment.start || CrossAxisAlignment.stretch || CrossAxisAlignment.baseline => 0,
          CrossAxisAlignment.end => width - child.size.width,
          CrossAxisAlignment.center => (width - child.size.width) / 2,
        };
        final double y = nextChildY;
      } else {
        // for row
        x = nextChildX;
        y = switch (crossAxisAlignment) {
          CrossAxisAlignment.start || CrossAxisAlignment.stretch || CrossAxisAlignment.baseline => 0,
          CrossAxisAlignment.end => height - child.size.height,
          CrossAxisAlignment.center => (height - child.size.height) / 2,
        };
      }

      final offset = Offset(x, y);

      child.position(offset);

      // calc y offset for next child
      nextChildX += child.size.width + startAndShift.stepShift;
    }
  }
}
