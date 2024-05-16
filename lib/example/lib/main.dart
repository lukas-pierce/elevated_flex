import 'package:flutter/material.dart';

import 'pages/row_and_col_behavior_example.dart';

void main() {
  runApp(const ElevatedFlexExampleApp());
}

class ElevatedFlexExampleApp extends StatelessWidget {
  const ElevatedFlexExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elevated Flex Example',
      home: RowAndColBehaviorExample(),
    );
  }
}
