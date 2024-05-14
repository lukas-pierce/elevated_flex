import 'package:flutter/material.dart';
import 'package:elevated_flex/elevated_flex.dart';

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
      home: ElevatedFlexExample(),
    );
  }
}

class ElevatedFlexExample extends StatelessWidget {
  const ElevatedFlexExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('example'),
      ),
    );
  }
}
