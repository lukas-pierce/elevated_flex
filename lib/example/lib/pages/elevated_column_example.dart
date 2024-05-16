import 'package:flutter/material.dart';

class ElevatedColumnExample extends StatelessWidget {
  const ElevatedColumnExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elevated Column'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SimpleChild(),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                boxShadow: const [BoxShadow(blurRadius: 10, spreadRadius: 3)],
              ),
              alignment: Alignment.center,
              child: const Text('child'),
            ),
            const SimpleChild(),
          ],
        ),
      ),
    );
  }
}

class SimpleChild extends StatelessWidget {
  const SimpleChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      alignment: Alignment.center,
      child: const Text('child'),
    );
  }
}
