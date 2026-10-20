import 'dart:convert';

import 'package:barber_shops/dto/sho-favorites.dart';
import 'package:barber_shops/model_service/session_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FavoritesModel {
  final SessionStorage _sessionStorage;

  FavoritesModel({SessionStorage? sessionStorage})
    : _sessionStorage = sessionStorage ?? SessionStorage();

  Future<List<ShopFavoritesDto>> getFavoritesShop({String? accessToken}) async {
    final token = await _resolveToken(accessToken);

    final uri = Uri.parse('http://10.0.2.2:4200/api/v1/favorites');
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    debugPrint('GET $uri -> ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch favorites (${response.statusCode})');
    }

    final decoded = jsonDecode(response.body);
    final List<Object?> items = switch (decoded) {
      List<Object?> list => list,
      Map<String, dynamic> body when body['favorites'] is List<Object?> =>
        body['favorites'] as List<Object?>,
      _ => throw const FormatException('Expected a list of favorites'),
    };

    return items
        .map(
          (item) =>
              ShopFavoritesDto.fromJson(Map<String, Object?>.from(item as Map)),
        )
        .toList();
  }

  Future<ShopFavoritesDto> addShopToFavorite({
    String? accessToken,
    required String barbershopId,
  }) async {
    final token = await _resolveToken(accessToken);

    final uri = Uri.parse('http://10.0.2.2:4200/api/v1/favorites');
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
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

  Future<ShopFavoritesDto> removeShopFromFavorite({
    String? accessToken,
    required String barbershopId,
  }) async {
    final token = await _resolveToken(accessToken);

    final uri = Uri.parse(
      'http://10.0.2.2:4200/api/v1/favorites/shop/$barbershopId',
    );
    final response = await http.delete(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    debugPrint('DELETE $uri -> ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception('Failed to remove favorite (${response.statusCode})');
    }

    final decoded = jsonDecode(response.body);
    final favorite = decoded is Map ? decoded['favorite'] : null;
    if (favorite is! Map) {
      throw const FormatException('Expected a favorite object');
    }

    return ShopFavoritesDto.fromJson(Map<String, Object?>.from(favorite));
  }

  Future<String> _resolveToken(String? accessToken) async {
    final token = accessToken ?? await _sessionStorage.getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception('Missing access token. Please sign in again.');
    }
    return token;
  }
}
