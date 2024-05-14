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

  @override
  void positionChildren() {
    final startAndShift = calcStartYAndShift();

    double nextChildMainCoord = startAndShift.startY;

    // positioning children with order according elevation
    for (int i = 0; i < childrenCount; i++) {
      final child = getChild(i);

      // for column
      final double x = switch (crossAxisAlignment) {
        CrossAxisAlignment.start || CrossAxisAlignment.stretch || CrossAxisAlignment.baseline => 0,
        CrossAxisAlignment.end => width - child.size.width,
        CrossAxisAlignment.center => (width - child.size.width) / 2,
      };
      final double y = nextChildMainCoord;
      final offset = Offset(x, y);

      child.position(offset);

      // calc y offset for next child
      nextChildMainCoord += child.size.height + startAndShift.stepShift;
    }
  }
}
