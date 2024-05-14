part of 'flex_settings_cubit.dart';

@immutable
sealed class FlexSettingsState {
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
}
