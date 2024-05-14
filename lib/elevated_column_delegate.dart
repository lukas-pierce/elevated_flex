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

  /// positioning children with order according elevation
  @override
  void positionChildren() {
    final startAndShift = calcStartYAndShift();
    double nextChildY = startAndShift.startY;

    for (int i = 0; i < childrenCount; i++) {
      final child = getChild(i);

      // for column
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
  }
}
