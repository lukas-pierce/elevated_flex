import 'package:flutter/material.dart';

import 'pages/elevated_column_example.dart';
import 'pages/elevated_row_example.dart';
import 'pages/column_and_row_behavior_example.dart';

void main() {
  runApp(const ElevatedFlexExampleApp());
}

class ElevatedFlexExampleApp extends StatelessWidget {
  const ElevatedFlexExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elevated Flex Examples',
      home: ExamplesList(),
    );
  }
}

class ExamplesList extends StatelessWidget {
  const ExamplesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const ElevatedColumnExample(),
              ));
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Elevated Row'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const ElevatedRowExample(),
              ));
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Column and Row Behavior'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const ColumnAndRowBehaviorExample(),
              ));
            },
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
