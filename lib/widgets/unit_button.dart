import 'package:flutter/material.dart';
import 'package:tractian_tree_view/widgets/elevated_button.dart';

class UnitButton extends StatelessWidget {
  static const String iconPath = 'assets/images/icon_factory.png';
  final String unitName;

  const UnitButton({super.key, required this.unitName});

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonWithIcon(
      width: 320,
      height: 80,
      iconPath: iconPath,
      text: unitName,
      colored: true,
    );
  }
}
