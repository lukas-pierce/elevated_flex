part of 'elevated_flex.dart';

class ElevatedFlex extends StatelessWidget {
  const ElevatedFlex({
    super.key,
    required this.direction,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.children = const <Widget>[],
  });

  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final List<Widget> children;

  bool get isVertical => direction == Axis.vertical;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children;
    if (isVertical && verticalDirection == VerticalDirection.up) {
      children = this.children.reversed.toList();
    } else {
      children = this.children;
    }

    final Map<int, Widget> indexedChildren = children.asMap();

    // sort children, move elevated widgets down
    final sortedIndexedChildren = indexedChildren.entries.sorted((a, b) {
      final aWidget = a.value;
      final bWidget = b.value;

      final aScore = aWidget is Elevated ? 1 : 0;
      final bScore = bWidget is Elevated ? 1 : 0;

      return aScore - bScore;
    });

    // convert children to BoxyId, but id saves their original order
    final boxyChildren = sortedIndexedChildren.map((entry) {
      final index = entry.key;
      final child = entry.value;

      return BoxyId(
        id: index,
        child: child,
      );
    }).toList();

    return CustomBoxy(
      delegate: _ElevatedFlexDelegate(
        direction: direction,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        verticalDirection: verticalDirection,
      ),
      children: boxyChildren,
    );
  }
}
