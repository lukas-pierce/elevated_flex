import 'package:flutter/material.dart';

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

class FlexSettings extends InheritedWidget {
  const FlexSettings({
    super.key,
    required this.state,
    required this.setMainAxisAlignment,
    required this.setMainAxisSize,
    required this.setCrossAxisAlignment,
    required this.setVerticalDirection,
    required super.child,
  });

  final FlexSettingsState state;
  final void Function(MainAxisAlignment) setMainAxisAlignment;
  final void Function(MainAxisSize) setMainAxisSize;
  final void Function(CrossAxisAlignment) setCrossAxisAlignment;
  final void Function(VerticalDirection) setVerticalDirection;

  static FlexSettings? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlexSettings>();
  }

  static FlexSettings of(BuildContext context) {
    final FlexSettings? result = maybeOf(context);
    assert(result != null, 'No InheritedProduct found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FlexSettings oldWidget) => state != oldWidget.state;
}

class FlexSettingsScope extends StatefulWidget {
  const FlexSettingsScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<FlexSettingsScope> createState() => _FlexSettingsScopeState();
}

class _FlexSettingsScopeState extends State<FlexSettingsScope> {
  FlexSettingsState state = const FlexSettingsState();

  @override
  Widget build(BuildContext context) {
    return FlexSettings(
      state: state,
      setMainAxisAlignment: _setMainAxisAlignment,
      setMainAxisSize: _setMainAxisSize,
      setCrossAxisAlignment: _setCrossAxisAlignment,
      setVerticalDirection: _setVerticalDirection,
      child: widget.child,
    );
  }

  void _setMainAxisAlignment(MainAxisAlignment val) {
    setState(() => state = state.copyWith(mainAxisAlignment: val));
  }

  void _setMainAxisSize(MainAxisSize val) {
    setState(() => state = state.copyWith(mainAxisSize: val));
  }

  void _setCrossAxisAlignment(CrossAxisAlignment val) {
    setState(() => state = state.copyWith(crossAxisAlignment: val));
  }

  void _setVerticalDirection(VerticalDirection val) {
    setState(() => state = state.copyWith(verticalDirection: val));
  }
}
