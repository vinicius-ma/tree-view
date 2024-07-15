import 'package:tractian_tree_view/models/asset_type.dart';
import 'package:tractian_tree_view/models/sensor_status.dart';
import 'package:tractian_tree_view/models/sensor_type.dart';

class Asset {
  final String id;
  final String name;
  final String? gatewayId;
  final String? locationId;
  final String? parentId;
  final String? sensorId;
  SensorType? sensorType;
  SensorStatus? status;

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
  }

  bool hasParentOrLocation(){
    return parentId != null || locationId != null;
  }

  AssetType? getType(){
    if(sensorType != null) return AssetType.component;
    if(hasParentOrLocation()) return AssetType.asset;
    if(locationId  == null) return AssetType.location;
    return null;
  }
}