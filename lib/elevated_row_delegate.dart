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

  /// positioning children with order according elevation
  @override
  void positionChildren() {
    if (direction == Axis.vertical) {

      // for column
      final startAndShift = calcStartYAndShift();
      double nextChildY = startAndShift.startY;

      for (int i = 0; i < childrenCount; i++) {
        final child = getChild(i);

        final double y = nextChildY;
        final double x = switch (crossAxisAlignment) {
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
        final double y = switch (crossAxisAlignment) {
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
}
