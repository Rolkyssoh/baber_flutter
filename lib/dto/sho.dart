class Shop {
  Shop({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.openStatus,
    required this.profileImage,
    required this.hours,
    required this.closingTime,
    required this.isActive,
    required this.latitude,
    required this.longitude,
    required this.manager,
    required this.managerId,
    required this.createdAt,
    required this.updatedAt,
  });
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String openStatus;
  final String profileImage;
  final String hours;
  final String closingTime;
  final bool isActive;
  final double latitude;
  final double longitude;
  final String manager;
  final String managerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  static Shop fromJson(Map<String, Object?> json) {
    return Shop(
      id: _string(json, 'id'),
      name: _string(json, 'name'),
      email: _string(json, 'email'),
      phone: _string(json, 'phone'),
      address: _string(json, 'address'),
      openStatus: _string(json, 'openStatus'),
      profileImage: _string(json, 'profileImage'),
      hours: _string(json, 'hours'),
      closingTime: _string(json, 'closingTime'),
      isActive: json['isActive'] as bool,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      manager: _string(json, 'manager'),
      managerId: _string(json, 'managerId'),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
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
