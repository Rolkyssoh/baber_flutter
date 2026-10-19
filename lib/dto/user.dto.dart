import 'package:barber_shops/dto/sho.dart';
import 'package:barber_shops/dto/shop_provided_services.dart';

class IUserDto {
  IUserDto({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.address,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.manager_barber_shop,
    required this.client_device,
    required this.user_clients_profile,
    required this.favoritesShop,
  });
  final String id;
  final String lastName;
  final String firstName;
  final String email;
  final String address;
  final String phone;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Shop manager_barber_shop;
  final Shop client_device;
  final Shop user_clients_profile;
  final List<Shop> favoritesShop;

  static IUserDto fromJson(Map<String, Object?> json) {
    return IUserDto(
      id: _string(json, 'id'),
      lastName: _string(json, 'lastName'),
      firstName: _string(json, 'firstName'),
      email: _string(json, 'email'),
      address: _string(json, 'address'),
      phone: _string(json, 'phone'),
      role: _string(json, 'role'),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      manager_barber_shop: Shop.fromJson(
        Map<String, dynamic>.from(json['manager_barber_shop'] as Map),
      ),
      client_device: Shop.fromJson(
        Map<String, dynamic>.from(json['client_device'] as Map),
      ),
      user_clients_profile: Shop.fromJson(
        Map<String, dynamic>.from(json['user_clients_profile'] as Map),
      ),
      favoritesShop: (json['favoritesShop'] as List<Object?>? ?? const [])
          .map(
            (service) =>
                Shop.fromJson(Map<String, Object?>.from(service as Map)),
          )
          .toList(),
    );
  }

  static String _string(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is String) {
      return value;
    }
    if (value is Map<String, dynamic>) {
      return value['name'] as String? ?? value['id'] as String? ?? '';
    }
    return '';
  }
}
