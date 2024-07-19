import 'dart:async';

import 'package:flutter/material.dart';
import '../models/asset.dart';
import '../models/company.dart';
import '../services/api_service.dart';
import '../theme/colors.dart';
import '../widgets/asset_expandable_item.dart';
import '../widgets/asset_item.dart';
import '../widgets/filter_button.dart';
import '../widgets/loading_indicator.dart';

class AssetsPage extends StatefulWidget {
  final Company company;

  const AssetsPage({super.key, required this.company});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  static ApiService apiService = ApiService();

  bool _isLoading = true;
  bool filterEnergy = false;
  bool filterCritical = false;
  String searchText = "";

  final fieldText = TextEditingController();

  Map<Asset?, List<Asset>> _map = {};
  List<Widget> _widgets = [];

  // TODO maybe use a FutureBuilder instead of this
  @override
  void initState() {
    super.initState();
    var future = getMapFromApi();
    future.then(
      (value) => setState(() => _map = value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TractianColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Assets',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
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
              (_isLoading || _map.values.isNotEmpty) && searchText.isEmpty
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

  Future<Map<Asset?, List<Asset>>> getMapFromApi() async {
    setLoading(true);
    List<Asset> assets = await apiService.getAssets(widget.company.id);
    // TODO the UI freezes at this point with a large number of assets
    var map = getChildren(null, assets, {});
    var widgets = getWidgets(null, map);
    setState(() {
      _widgets = widgets;
    });
    setLoading(false);
    return map;
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
    if (_map.values.isNotEmpty) {
      return Expanded(
        child: ListView(
          children: _widgets,
        ),
      );
    }
    return const Text('Nenhum item encontrado');
  }

  List<Widget> getWidgets(Asset? parent, Map<Asset?, List<Asset>> map) {
    List<Widget> widgets = [];
    for (Asset child in map[parent]!) {
      // child has children
      if (map[child]!.isNotEmpty) {
        var grandchildren = getWidgets(child, map);
        widgets.add(AssetExpandableItem(
          title: child.name,
          type: child.type,
          children: grandchildren,
        ));
      } else {
        widgets.add(AssetItem(
          title: child.name,
          type: child.type,
          status: child.status,
          sensorType: child.sensorType,
        ));
      }
    }
    return widgets;
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

  Map<Asset?, List<Asset>> getChildren(
    Asset? parent,
    List<Asset> allAssets,
    Map<Asset?, List<Asset>> map,
  ) {
    map[parent] = allAssets
        .where((child) => parent != null
            ? child.parentId == parent.id || child.locationId == parent.id
            : child.parentId == null && child.locationId == null)
        .toList();      

    var children = map[parent]!;

    for (Asset child in children) {
      var map2 = getChildren(child, allAssets, map);
      var grandchildren = map2[child];
      map[child] = grandchildren ?? [];
    }
    return map;
  }
}
