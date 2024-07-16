import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tractian_tree_view/models/asset.dart';
import 'package:tractian_tree_view/models/company.dart';
import 'package:tractian_tree_view/services/api_service.dart';
import 'package:tractian_tree_view/theme/colors.dart';
import 'package:tractian_tree_view/widgets/asset_expandable_item.dart';
import 'package:tractian_tree_view/widgets/asset_item.dart';
import 'package:tractian_tree_view/widgets/filter_button.dart';
import 'package:tractian_tree_view/widgets/loading_indicator.dart';

class AssetsPage extends StatefulWidget {
  final Company company;

  const AssetsPage({super.key, required this.company});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  static ApiService apiService = ApiService();

  List<Asset> assets = [];
  String companyId = "";

  bool filterEnergy = false;
  bool filterCritical = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      companyId = widget.company.id;
    });
    if (assets.isEmpty) getAssetsFromApi();
    return Scaffold(
      backgroundColor: TractianColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
              children: [searchBar(), filterBar()],
            ),
          ),
          assetsList(),
        ],
      ),
    );
  }

  Future<void> getAssetsFromApi() async {
    log('getAssetsFromApi');
    List<Asset> newAssets = await apiService.getAssets(companyId);
    setState(() {
      assets = newAssets;
    });
  }

  Expanded assetsList() {
    return Expanded(
      child: ListView(
        children: getChildren(null, assets),
      ),
    );
  }

  Row filterBar() {
    return Row(children: [
      const SizedBox(width: 8),
      FilterButton(
          assetName: 'bolt_outlined',
          text: 'Sensor de Energia',
          onPressed: (pressed) {
            setState(() {
              filterEnergy = pressed;
            });
          }),
      const SizedBox(width: 8),
      FilterButton(
        assetName: 'critical_outlined',
        text: 'Crítico',
        onPressed: (pressed) {
          setState(() {
            filterCritical = pressed;
          });
        },
      ),
    ]);
  }

  Row searchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar Ativo ou Local',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              prefixIcon: const Icon(
                Icons.search,
                color: TractianColors.darkGray,
              ),
              filled: true,
              fillColor: TractianColors.lightGray,
            ),
            style: const TextStyle(color: TractianColors.darkGray),
          ),
        ),
      ],
    );
  }

  Widget assetBody() {
    return assets.isNotEmpty ? assetsList() : const LoadingIndicator();
  }

  List<Widget> getChildren(
    Asset? parent,
    List<Asset> companyAssets, {
    int treeLevel = 0,
  }) {
    String? parentId = parent?.id;
    List<Asset> children =
        companyAssets.where((test) => test.parentId == parentId).toList();
    
    log("getChildren: ${parent?.name} has ${children.length} children");

    List<Widget> items = [];

    if (children.isNotEmpty) {
      // parent is expandable (if not null)
      if (parent != null && parent.getType() != null) {
        List<Widget> childrenItems = [];
        for (Asset currentAsset in children) {
          childrenItems.addAll(getChildren(currentAsset, companyAssets,
              treeLevel: treeLevel + 1));
        }

        var item = AssetExpandableItem(
          title: parent.name,
          type: parent.getType()!,
          treeLevel: treeLevel,
          children: childrenItems,
        );

        items.add(item);
      } else {
        for (Asset currentAsset in children) {
          items.addAll(getChildren(currentAsset, companyAssets,
              treeLevel: treeLevel + 1));
        }
      }
    } else {
      // it is the lowest level in tree
      if (parent != null && parent.getType() != null) {
        items.add(AssetItem(
          title: parent.name,
          type: parent.getType()!,
          sensorType: parent.sensorType,
          status: parent.status,
          treeLevel: treeLevel,
        ));
      }
    }
    return items;
  }
}
