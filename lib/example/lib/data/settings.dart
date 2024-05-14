import 'package:flutter/material.dart';

import '../bloc/flex_settings_cubit.dart';

class InheritedSettings extends InheritedWidget {
  const InheritedSettings({
    super.key,
    required this.state,
    required this.setMainAxisAlignment,
    required super.child,
  });

  final FlexSettingsState state;
  final void Function(MainAxisAlignment) setMainAxisAlignment;

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
      setMainAxisAlignment: setMainAxisAlignment,
      child: widget.child,
    );
  }

  void setMainAxisAlignment(MainAxisAlignment val) {
    setState(() {
      state = state.copyWith(mainAxisAlignment: val);
    });
  }
}
