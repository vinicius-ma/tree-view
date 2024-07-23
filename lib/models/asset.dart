
import 'asset_type.dart';
import 'sensor_status.dart';
import 'sensor_type.dart';

class Asset {
  final String id;
  final String name;
  final String? gatewayId;
  final String? locationId;
  final String? parentId;
  final String? sensorId;
  SensorType? sensorType;
  SensorStatus? status;
  late AssetType type;

  Asset({
    required this.id,
    required this.name,
    this.gatewayId,
    this.locationId,
    this.parentId,
    this.sensorId,
    String? sensorType,
    String? status,
  }){
    this.sensorType = SensorType.fromName(sensorType);
    this.status = SensorStatus.fromName(status);
    type = getType();
  }

  AssetType getType(){
    if(sensorType != null) return AssetType.component;
    return AssetType.asset;
  }

  bool isEnergy() => sensorType == SensorType.energy;
  bool isCritical() => status == SensorStatus.critical;
  bool contains(String text) => name.toLowerCase().contains(text.trim().toLowerCase());

  static List<Asset> fromMap(Map<String, List<dynamic>> map) {
    List<Asset> assets = [];
    map["assets"]?.forEach((asset) {
      assets.add(Asset(
        id: asset["id"],
        name: asset["name"],
        gatewayId: asset["gatewayId"],
        locationId: asset["locationId"],
        parentId: asset["parentId"],
        sensorId: asset["sensorId"],
        sensorType: asset["sensorType"],
        status: asset["status"],
      ));
    });
    return assets;
  } 
}