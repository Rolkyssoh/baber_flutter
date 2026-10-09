import 'package:barber_shops/dto/sho.dart';

class ShopProvidedServices {
  ShopProvidedServices({
    required this.id,
    this.parentId,
    required this.label,
    required this.description,
    this.price,
    this.durationMin,
    required this.imageUrl,
    required this.count,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.barberShops,
    this.service_shop_gallery,
  });

  final String id;
  final String? parentId;
  final String label;
  final String description;
  final double? price;
  final double? durationMin;
  final String imageUrl;
  final double? count;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Shop? barberShops;
  final String? service_shop_gallery;

  static ShopProvidedServices fromJson(Map<String, Object?> json) {
    return ShopProvidedServices(
      id: _string(json, 'id'),
      parentId: _string(json, 'parentId'),
      label: _string(json, 'label'),
      description: _string(json, 'description'),
      price: (json['price'] as num?)?.toDouble(),
      durationMin: (json['durationMin'] as num?)?.toDouble(),
      imageUrl: _string(json, 'imageUrl'),
      count: (json['count'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool?,
      createdAt: DateTime.tryParse(_string(json, 'createdAt')),
      updatedAt: DateTime.tryParse(_string(json, 'updatedAt')),
      barberShops: json['barberShops'] is Map
          ? Shop.fromJson(
              Map<String, Object?>.from(
                json['barberShops'] as Map<String, dynamic>,
              ),
            )
          : null,
      service_shop_gallery: json['service_shop_gallery'] as String?,
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
