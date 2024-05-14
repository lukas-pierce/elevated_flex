part of 'elevated_flex.dart';

/// Вижет который строит колонку
/// при этом какие-то дети могут быть выше остальных с позиции z-index
/// для этого нужно этих детей обернуть в [Elevated]
class ElevatedColumn extends StatelessWidget {
  const ElevatedColumn({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.children = const <Widget>[],
  });

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children;
    if (verticalDirection == VerticalDirection.down) {
      children = this.children;
    } else {
      children = this.children.reversed.toList();
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
      delegate: _ElevatedColumnDelegate(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        verticalDirection: verticalDirection,
      ),
      children: boxyChildren,
    );
  }
}
