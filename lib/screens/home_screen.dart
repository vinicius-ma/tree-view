import 'package:flutter/material.dart';
import 'package:tractian_tree_view/tests/companies.dart';
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

ListView homeBody() {
  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: Companies.values.length,
    itemBuilder: (BuildContext context, int index) {
      return UnitButton(
        unitName: Companies.values[index].name,
      );
    },
  );
}
