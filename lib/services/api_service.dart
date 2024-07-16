
import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tractian_tree_view/models/asset.dart';
import 'package:tractian_tree_view/models/company.dart';

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
    List<Response> responses = [];
    List<Asset> receivedAssets = [];
    List<int> lengths = [];
    responses.add(await _dio.get("$baseUrl/companies/$companyId/locations"));
    responses.add(await _dio.get("$baseUrl/companies/$companyId/assets"));

    for (var response in responses) {
      if(response.data is List<dynamic> && response.data.isNotEmpty) {
        Map<String, List<dynamic>> map = {};
        map["assets"] = response.data;
        var fromMap = Asset.fromMap(map);
        lengths.add(fromMap.length);
        receivedAssets.addAll(fromMap);
      }
    }
    log("ApiService: receivedAssets from $companyId: ${receivedAssets.length} " 
        "(${lengths[0]} locations, ${lengths[1]} assets)");
    return receivedAssets;
  }
}