part of 'elevated_flex.dart';

abstract class _ElevatedFlexDelegate extends BoxyDelegate {

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

}
