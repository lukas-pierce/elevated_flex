part of 'elevated_flex.dart';

/// Widget that builds a column in which some
/// children can be elevated relative to other children.
/// In CSS terms this is the same as `z-index: 1`
///
/// To elevate the child, wrap it by [Elevated] like this:
///
/// ElevatedColumn(
///   children: [
///     Elevated(child1),
///     child2,
///     child3,
///     Elevated(child4),
///     child5,
///     child6,
///   ]
/// )
class ElevatedColumn extends ElevatedFlex {
  const ElevatedColumn({
    super.key,
    super.mainAxisAlignment = MainAxisAlignment.start,
    super.mainAxisSize = MainAxisSize.max,
    super.crossAxisAlignment = CrossAxisAlignment.center,
    super.verticalDirection = VerticalDirection.down,
    super.children = const <Widget>[],
  }): super(
    direction: Axis.vertical,
  );

  @override
  Widget build(BuildContext context) {
    final List<Widget> children;
    if (direction == Axis.vertical && verticalDirection == VerticalDirection.up) {
      children = this.children.reversed.toList();
    } else {
      children = this.children;
    }

    final Map<int, Widget> indexedChildren = children.asMap();

    // sort children, move elevated widgets down
    List<MapEntry<int, Widget>> sortedIndexedChildren = indexedChildren.entries.sorted((a, b) {
      final aWidget = a.value;
      final bWidget = b.value;

      final aScore = aWidget is Elevated ? 1 : 0;
      final bScore = bWidget is Elevated ? 1 : 0;

      return aScore - bScore;
    });

    // convert children to BoxyId, but id saves their original order
    final boxyChildren = sortedIndexedChildren.map((MapEntry<int, Widget> entry) {
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
