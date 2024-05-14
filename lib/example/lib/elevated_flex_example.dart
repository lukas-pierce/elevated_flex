import 'package:flutter/material.dart';
import 'package:elevated_flex/elevated_flex.dart';

import 'example_settings.dart';

class ElevatedFlexExample extends StatelessWidget {
  const ElevatedFlexExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ExampleSettings(),
            SizedBox(height: 20),
            Divider(height: 0),
            Expanded(child: _ColumnsExample()),
            Divider(height: 0),
            Expanded(child: _RowsExample()),
          ],
        ),
      ),
    );
  }
}

class _ColumnsExample extends StatelessWidget {
  const _ColumnsExample();

  @override
  Widget build(BuildContext context) {
    const MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
    const MainAxisSize mainAxisSize = MainAxisSize.min;
    const CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;
    const VerticalDirection verticalDirection = VerticalDirection.down;

    return const Row(
      children: [
        Expanded(
          child: _ExampleContainer(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              verticalDirection: verticalDirection,
              children: [
                Elevated(child: _Item1()),
                _ItemCenter(),
                Elevated(child: _Item2()),
              ],
            ),
          ),
        ),
        Expanded(
          child: _ExampleContainer(
            alignment: Alignment.topCenter,
            child: ElevatedColumn(
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              verticalDirection: verticalDirection,
              children: [
                Elevated(child: _Item1()),
                _ItemCenter(),
                Elevated(child: _Item2()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RowsExample extends StatelessWidget {
  const _RowsExample();

  @override
  Widget build(BuildContext context) {
    const MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
    const MainAxisSize mainAxisSize = MainAxisSize.max;
    const CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;
    const VerticalDirection verticalDirection = VerticalDirection.down;

    return const Column(
      children: [
        Expanded(
          child: _ExampleContainer(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              verticalDirection: verticalDirection,
              children: [
                Elevated(child: _Item1()),
                _ItemCenter(),
                Elevated(child: _Item2()),
              ],
            ),
          ),
        ),
        Expanded(
          child: _ExampleContainer(
            alignment: Alignment.centerLeft,
            child: ElevatedRow(
              mainAxisAlignment: mainAxisAlignment,
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              verticalDirection: verticalDirection,
              children: [
                Elevated(child: _Item1()),
                _ItemCenter(),
                Elevated(child: _Item2()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ExampleContainer extends StatelessWidget {
  const _ExampleContainer({
    required this.child,
    this.alignment = Alignment.center,
  });

  final Widget child;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(fontSize: 10),
      textAlign: TextAlign.center,
      child: Container(
        // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        padding: const EdgeInsets.all(20),
        child: Align(
          alignment: alignment,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
            child: child,
          ),
        ),
      ),
    );
  }
}

const _shadow = BoxShadow(
  blurRadius: 5,
  spreadRadius: 5,
  color: Colors.black87,
);

class _Item1 extends StatelessWidget {
  const _Item1();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 50,
      width: 50,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.cyan,
        boxShadow: [_shadow],
      ),
      child: const Text('item1 (want top)'),
    );
  }
}

class _Item2 extends StatelessWidget {
  const _Item2();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 50,
      width: 50,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.lightGreen,
        boxShadow: [_shadow],
      ),
      child: const Text('item2 (want top)'),
    );
  }
}

class _ItemCenter extends StatelessWidget {
  const _ItemCenter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.orange,
        border: Border.all(color: Colors.red, width: 10, strokeAlign: BorderSide.strokeAlignOutside),
      ),
      child: const Text('center'),
    );
  }
}
