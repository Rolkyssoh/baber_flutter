import 'dart:io';

import 'package:barber_shops/dto/shop_provided_services.dart';
import 'package:barber_shops/model_service/shop_provided_services.model.dart';
import 'package:flutter/material.dart';

class ShopProvidedServicesViewModel extends ChangeNotifier {
  final ShopProvidedServicesModel model;
  List<ShopProvidedServices> services = [];
  Exception? error;
  bool isLoading = false;

  ShopProvidedServicesViewModel(this.model);

  Future<void> fetchPrincipalServices() async {
    isLoading = true;
    notifyListeners();
    try {
      services = await model.getAllPrincipalServices();
      debugPrint('Principal services loaded: $services');
      error = null;
    } on HttpException catch (e) {
      error = e;
      services = [];
    }
    isLoading = false;
    notifyListeners();
  }
}
