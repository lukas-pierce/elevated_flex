import 'package:flutter/material.dart';
import 'package:lives/model/product.dart';

class InheritedProduct extends InheritedWidget {
  const InheritedProduct({
    super.key,
    required this.product,
    required super.child,
  });

  final Product product;

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
