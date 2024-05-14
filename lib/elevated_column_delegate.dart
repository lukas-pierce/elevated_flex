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
}
