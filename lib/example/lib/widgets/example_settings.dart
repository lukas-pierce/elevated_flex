import 'package:flutter/material.dart';

class ExampleSettings extends StatelessWidget {
  const ExampleSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      width: double.infinity,
      child: SafeArea(
        bottom: false,
        child: Theme(
          data: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  return states.contains(MaterialState.selected) ? Colors.blue : Colors.white;
                }),
                foregroundColor: MaterialStateProperty.resolveWith((states) {
                  return states.contains(MaterialState.selected) ? Colors.white : Colors.black;
                }),
                shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                )),
                padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 3, horizontal: 5)),
                textStyle: const MaterialStatePropertyAll(TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: const MaterialStatePropertyAll(Size(20, 20)),
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                _SettingItem<MainAxisAlignment>(values: MainAxisAlignment.values),
                // SizedBox(height: 20),
                // _SettingItem(),
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
    this.selected,
    this.onChanged,
  });

  final List<T> values;
  final T? selected;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$T'),
        const SizedBox(height: 5),
        Wrap(
          // alignment: WrapAlignment.center,
          children: [
            ...values.map((value) {
              return ElevatedButton(
                onPressed: () {
                  //
                },
                statesController: MaterialStatesController()..value = {MaterialState.selected},
                child: Text(value.name),
              );
            }),
          ],
        ),
      ],
    );
  }
}