import 'package:flutter/material.dart';
import 'package:tractian_tree_view/theme/colors.dart';
import 'package:tractian_tree_view/widgets/elevated_button.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TractianColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text('Assets'),
        backgroundColor: TractianColors.darkBlue,
        foregroundColor: TractianColors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar Ativo ou Local',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          prefixIcon: const Icon(Icons.search, color: TractianColors.darkGray,),
                          filled: true,
                          fillColor: TractianColors.lightGray,
                        ),
                        style: const TextStyle(color: TractianColors.darkGray),
                      ),
                    ),
                  ],
                ),
                const Row(children: [
                  SizedBox(width: 8),
                  ElevatedButtonWithIcon(
                      iconPath: 'assets/images/bolt_outlined.png',
                      text: 'Sensor de Energia'),
                  SizedBox(width: 8),
                  ElevatedButtonWithIcon(
                      iconPath: 'assets/images/critical_outlined.png',
                      text: 'Crítico'),
                ])
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                AssetItem(
                  title: 'PRODUCTION AREA - RAW MATERIAL',
                  children: [
                    AssetItem(
                      title: 'CHARCOAL STORAGE SECTOR',
                      children: [
                        AssetItem(
                          title: 'CONVEYOR BELT ASSEMBLY',
                          children: [
                            AssetItem(
                              title: 'MOTOR TC01 COAL UNLOADING AF02',
                              children: [
                                AssetItem(
                                  title: 'MOTOR RT COAL AF01',
                                  icon: Icons.bolt,
                                  iconColor: Colors.green,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    AssetItem(
                      title: 'Machinery House',
                      children: [
                        AssetItem(
                          title: 'MOTORS H12D',
                          children: [
                            AssetItem(
                              title: 'MOTORS H12D - Stage 1',
                              icon: Icons.error,
                              iconColor: Colors.red,
                            ),
                            AssetItem(
                              title: 'MOTORS H12D - Stage 2',
                              icon: Icons.error,
                              iconColor: Colors.red,
                            ),
                            AssetItem(
                              title: 'MOTORS H12D - Stage 3',
                              icon: Icons.error,
                              iconColor: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                AssetItem(
                  title: 'EMPTY MACHINE HOUSE',
                ),
                AssetItem(
                  title: 'Fan - External',
                  icon: Icons.bolt,
                  iconColor: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AssetItem extends StatelessWidget {
  final String title;
  final List<AssetItem>? children;
  final IconData? icon;
  final Color? iconColor;

  const AssetItem({super.key, 
    required this.title,
    this.children,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          if (icon != null) Icon(icon, color: iconColor),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
      children: children ?? [],
    );
  }
}
