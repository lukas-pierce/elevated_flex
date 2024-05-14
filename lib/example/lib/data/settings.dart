import 'package:flutter/material.dart';

class InheritedProduct extends InheritedWidget {
  const InheritedProduct({
    super.key,
    required super.child,
  });

  static InheritedProduct? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedProduct>();
  }

  static InheritedProduct of(BuildContext context) {
    final InheritedProduct? result = maybeOf(context);
    assert(result != null, 'No InheritedProduct found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedProduct oldWidget) => product != oldWidget.product;
}
