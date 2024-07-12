import 'package:flutter/material.dart';
import 'package:tractian_tree_view/asset_screen.dart';
import 'package:tractian_tree_view/colors.dart';

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: TractianColors.lightBlue),
        primarySwatch: Colors.blue,
      ),
      home: const AssetsPage(),
    );
  }
}
