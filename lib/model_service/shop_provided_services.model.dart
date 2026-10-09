import 'dart:convert';

import 'package:barber_shops/dto/shop_provided_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShopProvidedServicesModel {
  Future<List<ShopProvidedServices>> getAllPrincipalServices() async {
    // final uri = Uri.https(
    //   String.fromEnvironment('http://10.0.2.2:4200'),
    //   '/api/v1/services/principal',
    // );
    final uri = Uri.parse('http://10.0.2.2:4200/api/v1/services/principal');
    final response = await http.get(uri);

    debugPrint('Response body PRICIPAL SERVICES: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch principal services');
    }

    final decoded = jsonDecode(response.body);
    final services = decoded is Map<String, dynamic>
        ? decoded['services']
        : decoded;

    if (services is! List) {
      throw Exception('Invalid principal services response payload');
    }

    return services
        .map(
          (item) => ShopProvidedServices.fromJson(
            Map<String, Object?>.from(item as Map),
          ),
        )
        .toList();
  }
}
