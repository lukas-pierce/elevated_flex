import 'package:flutter/material.dart';

class InheritedSettings extends InheritedWidget {
  const InheritedSettings({
    super.key,
    required super.child,
  });

  static InheritedSettings? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedSettings>();
  }

  static InheritedSettings of(BuildContext context) {
    final InheritedSettings? result = maybeOf(context);
    assert(result != null, 'No InheritedProduct found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedSettings oldWidget) => product != oldWidget.product;
}
