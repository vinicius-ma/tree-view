import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/asset.dart';
import '../models/company.dart';
import '../models/sensor_status.dart';
import '../models/sensor_type.dart';
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

  @override
  void initState() {
    super.initState();
    getMapFromApi();
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
              _isLoading ? Container() : filterBar(),
            ],
          ),
        ),
        Divider(
          color: Colors.black.withOpacity(0.1),
        ),
        _isLoading ? const LoadingIndicator() : assetsList(),
      ],
    );
  }

  Future<void> getMapFromApi() async {
    setLoading(true);
    log("getMapFromApi: starting");
    List<Asset> assets = await apiService.getAssets(widget.company.id);
    log("getMapFromApi: ended");
    setState(() {
      log("getChildren: starting");
      _map = getChildren(null, assets, {});
      log("getChildren: ended");
      log("getWidgets: starting");
      _widgets = getWidgets(null, _map);
      log("getWidgets: ended");
      setLoading(false);
    });
  }

  void setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  Widget assetsList() {
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
    List<Asset> filteredAssets = filterAssets(map[parent]!);

    for (Asset child in filteredAssets) {
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
              _widgets = getWidgets(null, _map);
            });
          }),
      const SizedBox(width: 8),
      FilterButton(
        assetName: 'critical_outlined',
        text: 'Crítico',
        onPressed: (pressed) {
          setState(() {
            filterCritical = pressed;
            _widgets = getWidgets(null, _map);
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
                searchText = value;
                _widgets = getWidgets(null, _map);
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
      _widgets = getWidgets(null, _map);
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

    for (Asset child in map[parent]!) {
      getChildren(child, allAssets, map);
    }

    return map;
  }

  List<Asset> filterAssets(List<Asset> assets) {
    List<Asset> filteredAssets = [];

    for (Asset asset in assets) {
      final matchesSearchText = searchText.isEmpty ||
          asset.name.toLowerCase().contains(searchText.toLowerCase());
      final matchesEnergyFilter =
          !filterEnergy || asset.sensorType == SensorType.energy;
      final matchesCriticalFilter =
          !filterCritical || asset.status == SensorStatus.critical;

      if (matchesSearchText && matchesEnergyFilter && matchesCriticalFilter) {
        filteredAssets.add(asset);
      } else if (hasFilteredDescendant(asset)) {
        filteredAssets.add(asset);
      }
    }

    return filteredAssets;
  }

  bool hasFilteredDescendant(Asset asset) {
    if (_map[asset] == null) return false;

    for (Asset child in _map[asset]!) {
      if (filterAssets([child]).isNotEmpty || hasFilteredDescendant(child)) {
        return true;
      }
    }

    return false;
  }
}
