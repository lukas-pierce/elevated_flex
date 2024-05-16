import 'package:flutter/material.dart';
import 'package:elevated_flex/elevated_flex.dart';

class ElevatedRowExample extends StatelessWidget {
  const ElevatedRowExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elevated Row'),
      ),
      body: const Center(
        child: ElevatedRow(
          mainAxisSize: MainAxisSize.min,
          children: [
            SimpleChild(),
            Elevated(child: SimpleChild(shadow: true)),
            SimpleChild(),
          ],
        ),
      ),
    );
  }
}

class SimpleChild extends StatelessWidget {
  const SimpleChild({super.key, this.shadow = false});

  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        boxShadow:
        shadow ? const [BoxShadow(blurRadius: 10, spreadRadius: 3)] : null,
      ),
      alignment: Alignment.center,
      child: const Text('child'),
    );
  }
}
