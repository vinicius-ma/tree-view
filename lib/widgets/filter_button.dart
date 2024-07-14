import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tractian_tree_view/widgets/elevated_button.dart';

class FilterButton extends StatefulWidget {
  final String assetName;
  final String text;

  final void Function(bool pressed) onPressed;

  const FilterButton({
    super.key,
    required this.assetName,
    required this.text,
    required this.onPressed,
  });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonWithIcon(
      iconPath: 'assets/images/${widget.assetName}.png',
      text: widget.text,
      onPressed: () {
        setState(() {
          pressed = !pressed;
          widget.onPressed(pressed);
        });
        Fluttertoast.showToast(
            msg: 'Filtro ${widget.text} ${pressed ? 'ativado' : 'desativado'}');
      },
      colored: pressed,
    );
  }
}
