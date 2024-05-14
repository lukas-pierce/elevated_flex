import 'package:flutter/material.dart';

import '../bloc/flex_settings_cubit.dart';

class InheritedSettings extends InheritedWidget {
  const InheritedSettings({
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

  static InheritedSettings? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedSettings>();
  }

  static InheritedSettings of(BuildContext context) {
    final InheritedSettings? result = maybeOf(context);
    assert(result != null, 'No InheritedProduct found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedSettings oldWidget) => state != oldWidget.state;
}

class Settings extends StatefulWidget {
  const Settings({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  FlexSettingsState state = const FlexSettingsState();

  @override
  Widget build(BuildContext context) {
    return InheritedSettings(
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
