
import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tractian_tree_view/models/asset.dart';
import 'package:tractian_tree_view/models/company.dart';
import 'package:tractian_tree_view/models/location.dart';

class ApiService {

  final Dio _dio = Dio();
  static const baseUrl = "https://fake-api.tractian.com";

  Future<List<Company>> getCompanies() async {
    // forcing a delay to show loading indicator
    await Future.delayed(const Duration(milliseconds: 500));
    Response response = await _dio.get("$baseUrl/companies");    
    if(response.data is List<dynamic> && response.data.isNotEmpty) {
      Map<String, List<dynamic>> map = {};
      map["companies"] = response.data;
      var receivedCompanies = Company.fromMap(map);
      log("ApiService: receivedCompanies: ${receivedCompanies.length}");
      return receivedCompanies;
    }
    return [];
  }

  Future<List<Asset>> getAssets(String companyId) async {
    List<Asset> receivedAssets = [];

    Response locationResponse = await _dio.get("$baseUrl/companies/$companyId/locations");
    Response assetResponse = await _dio.get("$baseUrl/companies/$companyId/assets");
    int numLocations = 0, numAssets = 0;

    if(locationResponse.data is List<dynamic> && locationResponse.data.isNotEmpty) {
      Map<String, List<dynamic>> map = {};
      map["locations"] = locationResponse.data;
      var fromMap = Location.fromMap(map);
      numLocations = fromMap.length;
      receivedAssets.addAll(fromMap);
    }

    if(assetResponse.data is List<dynamic> && assetResponse.data.isNotEmpty) {
      Map<String, List<dynamic>> map = {};
      map["assets"] = assetResponse.data;
      var fromMap = Asset.fromMap(map);
      numAssets = fromMap.length;
      receivedAssets.addAll(fromMap);
    }

    log("ApiService: receivedAssets from $companyId: ${receivedAssets.length} " 
        "($numLocations locations, $numAssets assets)");
    return receivedAssets;
  }
}