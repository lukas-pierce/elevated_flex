import 'package:flutter/material.dart';
import 'package:elevated_flex/elevated_flex.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/flex_settings_cubit.dart';
import 'widgets/example_settings.dart';
import 'widgets/example_items.dart';

class ElevatedFlexExample extends StatelessWidget {
  const ElevatedFlexExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => FlexSettingsCubit(),
        child: const Column(
          children: [
            ExampleSettings(),
            Expanded(
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Expanded(child: _ColumnsExample()),
                    Divider(height: 0),
                    Expanded(child: _RowsExample()),
                  ],
                ),
              ),
            ),
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

    return BlocBuilder<FlexSettingsCubit, FlexSettingsState>(builder: (context, state) {
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
                  Elevated(child: Item1()),
                  ItemCenter(),
                  Elevated(child: Item2()),
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
                  Elevated(child: Item1()),
                  ItemCenter(),
                  Elevated(child: Item2()),
                ],
              ),
            ),
          ),
        ],
      );
    });
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
                Elevated(child: Item1()),
                ItemCenter(),
                Elevated(child: Item2()),
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
                Elevated(child: Item1()),
                ItemCenter(),
                Elevated(child: Item2()),
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
