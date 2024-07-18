import 'package:flutter/material.dart';
import '../models/company.dart';
import '../screens/asset_screen.dart';
import 'elevated_button.dart';

class UnitButton extends StatelessWidget {
  static const String iconPath = 'assets/images/icon_factory.png';
  final Company company;

  const UnitButton({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonWithIcon(
      width: 320,
      height: 80,
      iconPath: iconPath,
      text: company.name,
      colored: true,
      onPressed: () {
        navigateToAssets(context);
      },
    );
  }

  void navigateToAssets(BuildContext context) {
    Navigator.push(context, 
      MaterialPageRoute(builder: (context) => AssetsPage(company: company)));
  }
}
