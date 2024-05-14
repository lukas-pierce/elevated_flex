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

  @override
  bool shouldRelayout(_ElevatedFlexDelegate oldDelegate) {
    return oldDelegate.direction != direction ||
        oldDelegate.mainAxisAlignment != mainAxisAlignment ||
        oldDelegate.mainAxisSize != mainAxisSize ||
        oldDelegate.crossAxisAlignment != crossAxisAlignment ||
        oldDelegate.verticalDirection != verticalDirection;
  }
}
