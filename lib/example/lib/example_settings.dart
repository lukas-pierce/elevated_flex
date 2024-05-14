import 'package:flutter/material.dart';

class ExampleSettings extends StatelessWidget {
  const ExampleSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
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
        child: const Column(
          children: [
            _SettingItem(),
            SizedBox(height: 20),
            _SettingItem(),
          ],
        ),
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('mainAxisAlignment'),
        const SizedBox(height: 5),
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
