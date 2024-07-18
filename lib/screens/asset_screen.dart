import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tractian_tree_view/models/asset.dart';
import 'package:tractian_tree_view/models/company.dart';
import 'package:tractian_tree_view/models/sensor_status.dart';
import 'package:tractian_tree_view/models/sensor_type.dart';
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

  bool _isLoading = true;

  final fieldText = TextEditingController();

  List<Asset> assets = [];
  List<Widget> widgets = [];

  String searchText = "";
  bool filterEnergy = false;
  bool filterCritical = false;

  @override
  Widget build(BuildContext context) {
    if (assets.isEmpty) getAssetsFromApi();
    getWidgets();
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
      body: assetBody(),
    );
  }

  Widget assetBody() {
    return Column(
        children: [
          Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Column(
            children: [
              searchBar(),
              (_isLoading || widgets.isNotEmpty) && searchText.isEmpty
                  ? filterBar()
                  : Container(),
            ],
            ),
        ),
        Divider(
                      color: Colors.black.withOpacity(0.1),
          ),
          assetsList(),
        ],
    );
  }

  Future<void> getAssetsFromApi() async {
    log('getAssetsFromApi');
    setLoading(true);
    List<Asset> newAssets = await apiService.getAssets(widget.company.id);
    setState(() {
      assets = newAssets;
    });
    setLoading(false);
  }

  getWidgets() {
    var aux =  getChildren(null, assets);
    setState(() {
      widgets = aux;
    });
  }
  
  setFilters({bool filterEnergy = false, bool filterCritical = false}) {
    setState(() {
      filterEnergy = filterEnergy;
      filterCritical = filterCritical;
    });
  }

  setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  Widget assetsList() {
    if (_isLoading) {
      return const LoadingIndicator();
    }
    if (widgets.isNotEmpty) {
    return Expanded(
      child: ListView(
          children: widgets,
      ),
    );
    }
    return const Text('Nenhum item encontrado');
  }

  Widget filterBar() {
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
              suffixIcon: searchText.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: clearText,
                    )
                  : null,
            ),
            style: const TextStyle(color: TractianColors.darkGray),
            onChanged: (value) {
              setState(() {
                filterEnergy = false;
                filterCritical = false;
                searchText = value;
              });
            },
            controller: fieldText,
          ),
        ),
      ],
    );
  }

  void clearText() {
    fieldText.clear();
    setState(() {
      searchText = "";
    });
  }

  List<Widget> getChildren(
    Asset? parent,
    List<Asset> companyAssets, {
    int treeLevel = 0,
    bool bypassSearchText = false,
  }) {
    String? parentId = parent?.id;
    List<Asset> children = companyAssets
        .where(
            (test) => test.locationId == parentId || test.parentId == parentId)
        .toList();

    List<Widget> items = [];

    if (children.isNotEmpty) {
      // parent is expandable (if not null)
      if (parent != null) {
        List<Widget> childrenItems = [];

        var parentFoundByName =
            searchText.isNotEmpty && parent.contains(searchText);

        for (Asset currentAsset in children) {
          var children = getChildren(currentAsset, companyAssets,
              treeLevel: treeLevel + 1,
              bypassSearchText: parentFoundByName | bypassSearchText);
          childrenItems.addAll(children);
        }

        //  in the case of expandable,
        // only add the parent if it has children
        // or matches the searching text
        if (childrenItems.isNotEmpty || parentFoundByName || bypassSearchText) {
        var item = AssetExpandableItem(
          title: parent.name,
            type: parent.getType(),
          treeLevel: treeLevel,
          children: childrenItems,
        );
        items.add(item);
        }
      } else {
        for (Asset current in children) {
          var currentAssetFoundByName =
              searchText.isNotEmpty && current.contains(searchText);
          items.addAll(getChildren(
            current,
            companyAssets,
            treeLevel: treeLevel + 1,
            bypassSearchText: currentAssetFoundByName | bypassSearchText,
          ));
        }
      }
    } else {
      // it is the lowest level in tree
      if (parent != null) {
        if ((filterEnergy && parent.isEnergy() || !filterEnergy) &&
            (filterCritical && parent.isCritical() || !filterCritical) &&
            (searchText.isNotEmpty && parent.contains(searchText) ||
                searchText.isEmpty || bypassSearchText)) {
        items.add(AssetItem(
          title: parent.name,
            type: parent.getType(),
          sensorType: parent.sensorType,
          status: parent.status,
          treeLevel: treeLevel,
        ));
        }
      }
    }
    return items;
  }
}
