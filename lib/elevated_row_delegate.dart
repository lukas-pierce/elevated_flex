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
    if (direction == Axis.vertical) {

    } else {
      final startAndShift = calcStartXAndShift();
      double nextChildX = startAndShift.startX;

      // positioning children with order according elevation
      for (int i = 0; i < childrenCount; i++) {
        final child = getChild(i);

        final double x, y;
        // for row
        x = nextChildX;
        y = switch (crossAxisAlignment) {
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
  }
}
