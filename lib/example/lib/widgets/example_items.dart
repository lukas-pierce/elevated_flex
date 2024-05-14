import 'package:flutter/material.dart';

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
