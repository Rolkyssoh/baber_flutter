import 'package:barber_shops/dto/shop_provided_services.dart';
import 'package:barber_shops/dto/user.dto.dart';

class ShopFavoritesDto {
  ShopFavoritesDto({
    required this.userId,
    required this.barbershopId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.barberShop,
  });
  final String userId;
  final String barbershopId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final IUserDto? user;
  final ShopProvidedServices? barberShop;

  static ShopFavoritesDto fromJson(Map<String, Object?> json) {
    return ShopFavoritesDto(
      userId: _string(json, 'userId'),
      barbershopId: _string(json, 'barbershopId'),
      createdAt: _date(json, 'createdAt'),
      updatedAt: _date(json, 'updatedAt'),
      user: json['user'] is Map
          ? IUserDto.fromJson(Map<String, Object?>.from(json['user'] as Map))
          : null,
      barberShop: json['barberShop'] is Map
          ? ShopProvidedServices.fromJson(
              Map<String, Object?>.from(json['barberShop'] as Map),
            )
          : null,
    );
  }

  static DateTime? _date(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is String) return DateTime.tryParse(value);
    return null;
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
