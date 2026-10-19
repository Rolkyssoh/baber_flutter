import 'dart:convert';

import 'package:barber_shops/dto/sho-favorites.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FavoritesModel {
  Future<List<ShopFavoritesDto>> getFavoritesShop({
    required String accessToken,
  }) async {
    final uri = Uri.parse('http://10.0.2.2:4200/api/v1/favorites');
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    debugPrint('GET $uri -> ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch favorites (${response.statusCode})');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw const FormatException('Expected a list of favorites');
    }

    return decoded
        .map(
          (item) =>
              ShopFavoritesDto.fromJson(Map<String, Object?>.from(item as Map)),
        )
        .toList();
  }

  Future<ShopFavoritesDto> addShopToFavorite({
    required String accessToken,
    required String barbershopId,
  }) async {
    final uri = Uri.parse('http://10.0.2.2:4200/api/v1/favorites');
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'barbershopId': barbershopId}),
    );

    debugPrint('POST $uri -> ${response.statusCode}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add favorite (${response.statusCode})');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map) {
      throw const FormatException('Expected a favorite object');
    }

    return ShopFavoritesDto.fromJson(Map<String, Object?>.from(decoded));
  }
}
