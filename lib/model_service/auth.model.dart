import 'dart:convert';

import 'package:barber_shops/dto/auth.dto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthModel {
  static final Uri _baseUri = Uri.parse('http://10.0.2.2:4200/api/v1/');

  Future<void> registerUser(RegisterDto request) async {
    await _post('auth/register', request.toJson());
  }

  Future<LoginResponseDto> loginUser(LoginDto request) async {
    final response = await _post('auth/login', request.toJson());

    final decoded = jsonDecode(response.body);
    debugPrint('Response body: ${response.body}');
    if (decoded is! Map) {
      throw const FormatException('Expected an authentication response');
    }

    return LoginResponseDto.fromJson(Map<String, Object?>.from(decoded));
  }

  Future<http.Response> _post(String path, Map<String, Object?> body) async {
    final uri = _baseUri.resolve(path);
    final response = await http.post(
      uri,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    debugPrint('POST $uri -> ${response.statusCode}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(_errorMessage(response));
    }

    return response;
  }

  String _errorMessage(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        final message = decoded['message'];
        debugPrint('MESSAGE BODYYYYYYYYYYY::::::: $message');
        if (message is String) {
          return message;
        }
        if (message is List) {
          return message.join('\n');
        }
      }
    } on FormatException {
      // Use the raw response below when the backend did not return JSON.
    }

    final body = response.body.trim();
    return body.isEmpty
        ? 'Erreur serveur (${response.statusCode})'
        : 'Erreur serveur (${response.statusCode}): $body';
  }
}
