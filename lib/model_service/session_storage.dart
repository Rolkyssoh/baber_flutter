import 'package:barber_shops/dto/auth.dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionStorage {
  static const _tokenKey = 'auth.access_token';
  static const _userIdKey = 'auth.user_id';
  static const _emailKey = 'auth.user_email';
  static const _nameKey = 'auth.user_name';
  static const _onboardingKey = 'onboarding.completed';

  Future<void> saveSession(LoginResponseDto session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, session.accessToken);
    await prefs.setString(_userIdKey, session.user.id);
    await prefs.setString(_emailKey, session.user.email);
    await prefs.setString(
      _nameKey,
      '${session.user.firstName} ${session.user.lastName}'.trim(),
    );
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_nameKey);
  }

  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> markOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }
}
