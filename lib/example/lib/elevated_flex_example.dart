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
                bottom: false,
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
    return BlocBuilder<FlexSettingsCubit, FlexSettingsState>(builder: (context, state) {
      return Row(
        children: [
          Expanded(
            child: _ExampleContainer(
              title: 'Column',
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: state.mainAxisAlignment,
                mainAxisSize: state.mainAxisSize,
                crossAxisAlignment: state.crossAxisAlignment,
                verticalDirection: state.verticalDirection,
                children: const [
                  Elevated(child: Item1()),
                  ItemCenter(),
                  Elevated(child: Item2()),
                ],
              ),
            ),
          ),
          Expanded(
            child: _ExampleContainer(
              title: 'ElevatedColumn',
              alignment: Alignment.topCenter,
              child: ElevatedColumn(
                mainAxisAlignment: state.mainAxisAlignment,
                mainAxisSize: state.mainAxisSize,
                crossAxisAlignment: state.crossAxisAlignment,
                verticalDirection: state.verticalDirection,
                children: const [
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
    return BlocBuilder<FlexSettingsCubit, FlexSettingsState>(builder: (context, state) {
      return Column(
        children: [
          Expanded(
            child: _ExampleContainer(
              title: 'Row',
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: state.mainAxisAlignment,
                mainAxisSize: state.mainAxisSize,
                crossAxisAlignment: state.crossAxisAlignment,
                verticalDirection: state.verticalDirection,
                children: const [
                  Elevated(child: Item1()),
                  ItemCenter(),
                  Elevated(child: Item2()),
                ],
              ),
            ),
          ),
          Expanded(
            child: _ExampleContainer(
              title: 'ElevatedRow',
              alignment: Alignment.centerLeft,
              child: ElevatedRow(
                mainAxisAlignment: state.mainAxisAlignment,
                mainAxisSize: state.mainAxisSize,
                crossAxisAlignment: state.crossAxisAlignment,
                verticalDirection: state.verticalDirection,
                children: const [
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

class _ExampleContainer extends StatelessWidget {
  const _ExampleContainer({
    this.title,
    this.alignment = Alignment.center,
    required this.child,
  });

  final String? title;
  final AlignmentGeometry alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(fontSize: 10),
      textAlign: TextAlign.center,
      child: Container(
        // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        padding: const EdgeInsets.all(35),
        child: Align(
          alignment: alignment,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                child: child,
              ),
              if (title != null)
                Positioned(
                  top: -27,
                  child: Text(title!, style: TextStyle(fontSize: 12, color: Colors.blueAccent)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
