
import '../models/asset.dart';
import 'companies.dart';

class Assets {

  static final _values = _initValues();

  static Map<String, List<Asset>> get() {
    return _values;
  }

  static List<Asset> getByCompany(String companyId) {
    return _values[companyId] ?? [];
  }

  static Map<String, List<Asset>> _initValues() {
    Map<String, List<Asset>> values = {};
    for (final company in Companies.values) {
      values[company.id] = [
        Asset(
          id: "656a07bbf2d4a1001e2144c2",
          locationId: "656a07b3f2d4a1001e2144bf",
          name: "CONVEYOR BELT ASSEMBLY",
          parentId: null,
          sensorType: null,
          status: null,
        ),
        Asset(
          gatewayId: "QHI640",
          id: "656734821f4664001f296973",
          locationId: null,
          name: "Fan - External",
          parentId: null,
          sensorId: "MTC052",
          sensorType: "energy",
          status: "operating",
        ),
        Asset(
          id: "656734448eb037001e474a62",
          locationId: "656733b1664c41001e91d9ed",
          name: "Fan H12D",
          parentId: null,
          sensorType: null,
          status: null,
        ),
        Asset(
          gatewayId: "FRH546",
          id: "656a07cdc50ec9001e84167b",
          locationId: null,
          name: "MOTOR RT COAL AF01",
          parentId: "656a07c3f2d4a1001e2144c5",
          sensorId: "FIJ309",
          sensorType: "vibration",
          status: "operating",
        ),
        Asset(
          id: "656a07c3f2d4a1001e2144c5",
          locationId: null,
          name: "MOTOR TC01 COAL UNLOADING AF02",
          parentId: "656a07bbf2d4a1001e2144c2",
          sensorType: null,
          status: null,
        ),
        Asset(
          gatewayId: "QBK282",
          id: "6567340c1f4664001f29622e",
          locationId: null,
          name: "Motor H12D- Stage 1",
          parentId: "656734968eb037001e474d5a",
          sensorId: "CFX848",
          sensorType: "vibration",
          status: "alert",
        ),
        Asset(
          gatewayId: "VHS387",
          id: "6567340c664c41001e91dceb",
          locationId: null,
          name: "Motor H12D-Stage 2",
          parentId: "656734968eb037001e474d5a",
          sensorId: "GYB119",
          sensorType: "vibration",
          status: "alert",
        ),
        Asset(
          gatewayId: "VZO694",
          id: "656733921f4664001f295e9b",
          locationId: null,
          name: "Motor H12D-Stage 3",
          parentId: "656734968eb037001e474d5a",
          sensorId: "SIF016",
          sensorType: "vibration",
          status: "alert",
        ),
        Asset(
          id: "656734968eb037001e474d5a",
          locationId: "656733b1664c41001e91d9ed",
          name: "Motors H12D",
          parentId: null,
          sensorType: null,
          status: null,
        )
      ];
    }
    return values;
  }
}
