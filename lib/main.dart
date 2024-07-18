
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/colors.dart';

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
      home: const HomePage(),
    );
  }
}
