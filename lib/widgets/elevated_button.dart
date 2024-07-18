import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ElevatedButtonWithIcon extends StatelessWidget {
  final String iconPath;
  final String text;
  final bool colored;

  final double? width;
  final double? height;

  final VoidCallback onPressed;

  const ElevatedButtonWithIcon({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.colored = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: getBackgroundColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 16),
              child: ImageIcon(
                AssetImage(iconPath),
                color: getForegroundColor(),
                size: 24,
              ),
            ),
            Text(
              text,
              style:
                  colored ? const ColoredTextStyle() : const NormalTextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  Color getBackgroundColor() {
    return colored ? TractianColors.lightBlue : TractianColors.white;
  }

  getForegroundColor() {
    return colored ? TractianColors.white : TractianColors.darkGray;
  }
}

class NormalTextStyle extends TextStyle {
  const NormalTextStyle(
      {super.fontSize,
      super.fontWeight,
      super.color = TractianColors.darkGray,
      super.fontFamily});
}

class ColoredTextStyle extends TextStyle {
  const ColoredTextStyle(
      {super.fontSize,
      super.fontWeight,
      super.color = TractianColors.white,
      super.fontFamily});
}
