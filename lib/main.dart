import 'package:flutter/material.dart';
import 'package:tractian_tree_view/colors.dart';

import 'unit_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tractian Units',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            color: TractianColors.white,
            'assets/tractian_logo.png',
            height: 40,
          ),
        ),
        backgroundColor: TractianColors.darkBlue,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            UnitButton(unitName: 'Jaguar Unit'),
            SizedBox(height: 8),
            UnitButton(unitName: 'Tobias Unit'),
            SizedBox(height: 8),
            UnitButton(unitName: 'Apex Unit'),
          ],
        ),
      ),
    );
  }
}
