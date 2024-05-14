import 'package:flutter/material.dart';

import '../bloc/flex_settings_cubit.dart';

class InheritedSettings extends InheritedWidget {
  const InheritedSettings({
    super.key,
    required this.state,
    required super.child,
  });

  final FlexSettingsState state;

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
