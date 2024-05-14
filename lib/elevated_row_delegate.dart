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
