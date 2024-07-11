import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tractian_tree_view/colors.dart';

class UnitButton extends StatelessWidget {
  final String unitName;

  const UnitButton({super.key, required this.unitName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 320,
      height: 80,
      child: ElevatedButton(
        onPressed: () => _onUnitPressed(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: TractianColors.lightBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 16),
              child: ImageIcon(
                const AssetImage('assets/icon_factory.png'),
                color: TractianColors.white,
                size: 24,
              ),
            ),
            Text(
              unitName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onUnitPressed(BuildContext context) {
    Fluttertoast.showToast(msg: 'Pressed $unitName');
  }
}
