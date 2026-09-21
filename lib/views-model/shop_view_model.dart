import 'package:barber_shops/dto/sho.dart';
import 'package:barber_shops/model_service/shop_model.dart';
import 'package:flutter/material.dart';

class ShopViewModel extends ChangeNotifier {
  final ShopModel model;
  List<Shop> shop = [];
  Exception? error;
  bool isLoading = false;

  ShopViewModel(this.model);

  Future<void> fetchShopData() async {
    isLoading = true;
    notifyListeners();
    try {
      shop = await model.getActiveShop();
      debugPrint('SHOP loaded: ${shop.length} item(s)');
      if (shop.isNotEmpty) {
        debugPrint('First shop: ${shop.first}');
      }
      error = null;
    } on Exception catch (e) {
      debugPrint('SHOP loading error: $e');
      error = e;
      shop = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
