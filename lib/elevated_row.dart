part of 'elevated_flex.dart';

/// Widget that builds a row in which some
/// children can be elevated relative to other children.
/// In CSS terms this is the same as `z-index: 1`
///
/// To elevate the child, wrap it by [Elevated] like this:
///
/// ElevatedRow(
///   children: [
///     Elevated(child1),
///     child2,
///     child3,
///     Elevated(child4),
///     child5,
///     child6,
///   ]
/// )
class ElevatedRow extends ElevatedFlex {
  const ElevatedRow({
    super.key,
    super.mainAxisAlignment = MainAxisAlignment.start,
    super.mainAxisSize = MainAxisSize.max,
    super.crossAxisAlignment = CrossAxisAlignment.center,
    super.verticalDirection = VerticalDirection.down,
    super.children = const <Widget>[],
  }) : super(
          direction: Axis.horizontal,
        );
}
