import 'package:flutter/material.dart';

class ExampleSettings extends StatelessWidget {
  const ExampleSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('mainAxisAlignment'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                //
              },
              statesController: MaterialStatesController()..value = {MaterialState.selected},
              child: const Text('start'),
            ),
            ElevatedButton(
              onPressed: () {
                //
              },
              child: const Text('end'),
            ),
            ElevatedButton(
              onPressed: () {
                //
              },
              child: const Text('center'),
            ),
            ElevatedButton(
              onPressed: () {
                //
              },
              child: const Text('spaceBetween'),
            ),
            ElevatedButton(
              onPressed: () {
                //
              },
              child: const Text('spaceAround'),
            ),
            ElevatedButton(
              onPressed: () {
                //
              },
              child: const Text('spaceEvenly'),
            ),
          ],
        ),
      ],
    );
  }
}
