import 'package:tractian_tree_view/models/asset.dart';
import 'package:tractian_tree_view/models/asset_type.dart';

class Location extends Asset{
  Location({
    required super.id,
    required super.name,
    super.parentId,
    });

    @override
    AssetType getType() => AssetType.location;

    static List<Location> fromMap(Map<String, List<dynamic>> map) {
    List<Location> locations = [];
    map["locations"]?.forEach((location) {
      locations.add(Location(
        id: location["id"],
        name: location["name"],
        parentId: location["parentId"],
      ));
    });
    return locations;
  }
}