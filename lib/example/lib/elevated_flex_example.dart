import 'package:flutter/material.dart';
import 'package:elevated_flex/elevated_flex.dart';

class ElevatedFlexExample extends StatelessWidget {
  const ElevatedFlexExample({super.key});

  @override
  Widget build(BuildContext context) {
    const MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceEvenly;
    const MainAxisSize mainAxisSize = MainAxisSize.max;
    const CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;
    const VerticalDirection verticalDirection = VerticalDirection.down;

    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _Example(
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
                    _Example(
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
                  ],
                ),
              ),
              Divider(height: 0),
              Expanded(
                child: Row(
                  children: [
                    _Example(
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
                    _Example(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// todo rename _ExampleContainer
class _Example extends StatelessWidget {
  const _Example({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // decoration: BoxDecoration(border: Border.all()),
        padding: const EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
            child: child,
          ),
        ),
      ),
    );
  }
}