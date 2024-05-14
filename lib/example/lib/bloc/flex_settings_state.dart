part of 'flex_settings_cubit.dart';

@immutable
final class FlexSettingsState {
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;

  const FlexSettingsState({
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
  });

  FlexSettingsState copyWith({
    MainAxisAlignment? mainAxisAlignment,
    MainAxisSize? mainAxisSize,
    CrossAxisAlignment? crossAxisAlignment,
    VerticalDirection? verticalDirection,
  }) {
    return FlexSettingsState(
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      mainAxisSize: mainAxisSize ?? this.mainAxisSize,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      verticalDirection: verticalDirection ?? this.verticalDirection,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FlexSettingsState &&
        other.mainAxisAlignment == mainAxisAlignment &&
        other.mainAxisSize == mainAxisSize &&
        other.crossAxisAlignment == crossAxisAlignment &&
        other.verticalDirection == verticalDirection;
  }

  @override
  int get hashCode => Object.hash(
        mainAxisAlignment,
        mainAxisSize,
        crossAxisAlignment,
        verticalDirection,
      );
}
