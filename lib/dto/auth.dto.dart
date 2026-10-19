class RegisterDto {
  const RegisterDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.phone,
    this.address,
    this.role,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? phone;
  final String? address;
  final String? role;

  Map<String, Object?> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password,
    if (phone != null && phone!.isNotEmpty) 'phone': phone,
    if (address != null && address!.isNotEmpty) 'address': address,
    if (role != null && role!.isNotEmpty) 'role': role,
  };
}

class LoginDto {
  const LoginDto({required this.email, required this.password});

  final String email;
  final String password;

  Map<String, Object?> toJson() => {'email': email, 'password': password};
}

class AuthUserDto {
  const AuthUserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.address,
    this.role,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? address;
  final String? role;

  factory AuthUserDto.fromJson(Map<String, Object?> json) {
    return AuthUserDto(
      id: _string(json, 'id'),
      firstName: _string(json, 'firstName'),
      lastName: _string(json, 'lastName'),
      email: _string(json, 'email'),
      phone: _nullableString(json, 'phone'),
      address: _nullableString(json, 'address'),
      role: _nullableString(json, 'role'),
    );
  }

  static String _string(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is String) return value;
    if (value is num) return value.toString();
    return '';
  }

  static String? _nullableString(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is String) return value;
    if (value is num) return value.toString();
    return null;
  }
}

class LoginResponseDto {
  const LoginResponseDto({required this.accessToken, required this.user});

  final String accessToken;
  final AuthUserDto user;

  factory LoginResponseDto.fromJson(Map<String, Object?> json) {
    final rawUser = json['user'];
    return LoginResponseDto(
      accessToken: json['access_token'] as String? ?? '',
      user: AuthUserDto.fromJson(
        rawUser is Map ? Map<String, Object?>.from(rawUser) : const {},
      ),
    );
  }
}
