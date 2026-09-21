import 'dart:convert';

import 'package:barber_shops/dto/sho.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ShopModel {
  Future<List<Shop>> getActiveShop() async {
    final uri = Uri.parse('http://10.0.2.2:4200/api/v1/barber-shop/active');
    final response = await get(uri);

    debugPrint('GET $uri -> ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch active shop');
    }

    final decoded = jsonDecode(response.body);
    final json = switch (decoded) {
      List<Object?> items => items,
      Map<String, dynamic> body when body['shops'] is List<Object?> =>
        body['shops'] as List<Object?>,
      Map<String, dynamic> body when body['data'] is List<Object?> =>
        body['data'] as List<Object?>,
      Map<String, dynamic> body when body['shop'] is Map<String, dynamic> => [
        body['shop'],
      ],
      Map<String, dynamic> body => [body],
      _ => throw const FormatException('Unexpected active shop response'),
    };

    final shops = json
        .map(
          (item) => Shop.fromJson(
            Map<String, Object?>.from(item as Map<String, dynamic>),
          ),
        )
        .toList();

    debugPrint('Decoded shops: ${shops}');
    return shops;
  }
}
