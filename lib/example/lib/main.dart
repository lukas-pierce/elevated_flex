import 'package:flutter/material.dart';

import 'pages/column_and_row_behavior_example.dart';

void main() {
  runApp(const ElevatedFlexExampleApp());
}

class ElevatedFlexExampleApp extends StatelessWidget {
  const ElevatedFlexExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elevated Flex Examples',
      home: Scaffold(
        // child: ColumnAndRowBehaviorExample()
        appBar: AppBar(
          title: const Text('Examples:'),
          centerTitle: false,
        ),
        body: ListView(
          children: [
            const Divider(height: 1),
            ListTile(
              title: const Text('Elevated Column'),
              onTap: () {
                //
              },
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text('Elevated Row'),
              onTap: () {
                //
              },
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text('Column And Row Behavior'),
              onTap: () {
                //
              },
            ),
            const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
