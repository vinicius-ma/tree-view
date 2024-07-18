import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../models/company.dart';
import '../services/api_service.dart';
import '../services/api_state.dart';
import '../theme/colors.dart';
import '../widgets/error_indicator.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/unit_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Company> companies = [];
  static ApiService apiService = ApiService();

  StreamBuilder<ApiState> get homeBody => StreamBuilder<ApiState>(
        stream: _isLoading,
        initialData: ApiState.isLoading,
        builder: (context, snapshot) {
          Widget widget;
          if (snapshot.hasError) {
            widget = ErrorIndicator(error: snapshot.error.toString());
          } else {
            if (snapshot.data == ApiState.isLoading) {
              widget = const LoadingIndicator();
            } else {
              widget = companiesList();
            }
          }
          return widget;
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: homeBody,
    );
  }

  Future<void> getCompaniesFromApi() async {
    log('getCompaniesFromApi');
    var newCompanies = await apiService.getCompanies();
    setState(() {
      companies = newCompanies;
    });
  }

  final Stream<ApiState> _isLoading = (() {
    late final StreamController<ApiState> controller;
    controller = StreamController<ApiState>(
      onListen: () async {
        controller.add(ApiState.isLoading);
        companies = await apiService.getCompanies();
        controller.add(ApiState.done);
        await controller.close();
      },
    );
    return controller.stream;
  })();

  AppBar homeAppBar() {
    return AppBar(
      title: Center(
        child: Image.asset(
          color: TractianColors.white,
          'assets/images/tractian_logo.png',
          height: 40,
        ),
      ),
      backgroundColor: TractianColors.darkBlue,
    );
  }

  RefreshIndicator companiesList() {

    if(companies.isEmpty) getCompaniesFromApi();

    return RefreshIndicator(
      onRefresh: getCompaniesFromApi ,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: companies.length,
        itemBuilder: (BuildContext context, int index) {
          return UnitButton(
            company: companies[index],
          );
        },
        
      ),
    );
  }
}
