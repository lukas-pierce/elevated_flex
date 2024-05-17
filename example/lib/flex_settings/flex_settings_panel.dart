import 'package:flutter/material.dart';

import 'flex_settings.dart';

class FlexSettingsPanel extends StatelessWidget {
  const FlexSettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      child: SafeArea(
        bottom: false,
        child: Theme(
          data: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.white.withOpacity(0.5);
                  }
                  final isSelected = states.contains(MaterialState.selected);
                  return isSelected ? Colors.blue : Colors.white;
                }),
                foregroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey;
                  }
                  final isSelected = states.contains(MaterialState.selected);
                  return isSelected ? Colors.white : Colors.black;
                }),
                shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                )),
                padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 5,
                )),
                textStyle: const MaterialStatePropertyAll(
                  TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: const MaterialStatePropertyAll(Size(20, 20)),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // mainAxisSize
                _SettingItem<MainAxisSize>(
                  values: MainAxisSize.values,
                  selected: FlexSettings.of(context).state.mainAxisSize,
                  onChanged: (val) {
                    FlexSettings.of(context).setMainAxisSize(val);
                  },
                ),

                // mainAxisAlignment
                const SizedBox(height: 10),
                _SettingItem<MainAxisAlignment>(
                  values: MainAxisAlignment.values,
                  selected: FlexSettings.of(context).state.mainAxisAlignment,
                  onChanged: (val) {
                    FlexSettings.of(context).setMainAxisAlignment(val);
                  },
                ),

                // crossAxisAlignment
                const SizedBox(height: 10),
                _SettingItem<CrossAxisAlignment>(
                  values: CrossAxisAlignment.values,
                  disabledValues: const [CrossAxisAlignment.baseline],
                  selected: FlexSettings.of(context).state.crossAxisAlignment,
                  onChanged: (val) {
                    FlexSettings.of(context).setCrossAxisAlignment(val);
                  },
                ),

                // verticalDirection
                const SizedBox(height: 10),
                _SettingItem<VerticalDirection>(
                  values: VerticalDirection.values,
                  selected: FlexSettings.of(context).state.verticalDirection,
                  onChanged: (val) {
                    FlexSettings.of(context).setVerticalDirection(val);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingItem<T extends Enum> extends StatelessWidget {
  const _SettingItem({
    required this.values,
    this.disabledValues = const [],
    this.selected,
    this.onChanged,
  });

  final List<T> values;
  final List<T> disabledValues;
  final T? selected;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              constraints: const BoxConstraints(minWidth: 140),
              child: Text('$T'),
            ),
            const SizedBox(height: 5),
            Flexible(
              child: Wrap(
                // alignment: WrapAlignment.center,
                children: [
                  ...values.map<List<Widget>>((value) {
                    final disabled = disabledValues.contains(value);
                    return [
                      ElevatedButton(
                        onPressed: (!disabled && onChanged != null)
                            ? () => onChanged?.call(value)
                            : null,
                        statesController: value == selected
                            ? MaterialStatesController({MaterialState.selected})
                            : null,
                        child: Text(value.name),
                      ),
                      // <br>
                      if (value == MainAxisAlignment.center) ...[
                        const SizedBox(width: 1000),
                      ],
                    ];
                  }).expand((e) => e),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
