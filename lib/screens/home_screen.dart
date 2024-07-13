import 'package:flutter/material.dart';
import 'package:tractian_tree_view/theme/colors.dart';
import 'package:tractian_tree_view/widgets/unit_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: homeBody(),
    );
  }
}

AppBar homeAppBar() {
  return AppBar(
    title: Center(
      child: Image.asset(
        color: TractianColors.white,
        'assets/images/tractian_logo.png',
        height: 40,
      ),
    ),
    backgroundColor: TractianColors.darkBlue,
  );
}

Center homeBody() {
  return const Center(
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
  );
}
