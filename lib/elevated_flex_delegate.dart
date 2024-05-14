part of 'elevated_flex.dart';

abstract class _ElevatedFlexDelegate extends BoxyDelegate {

  double get sumChildrenHeight {
    return children.fold(0.0, (sum, child) => sum + child.size.height);
  }

  double get sumChildrenWidth {
    return children.fold(0.0, (sum, child) => sum + child.size.width);
  }

}
