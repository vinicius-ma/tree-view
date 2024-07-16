import 'package:flutter/material.dart';
import 'package:tractian_tree_view/theme/colors.dart';

class ErrorIndicator extends StatelessWidget {
  final String? error;
  const ErrorIndicator({super.key, this.error = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline,
            color: TractianColors.red,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Error: $error'),
          ),
        ],
      ),
    );
  }
}
