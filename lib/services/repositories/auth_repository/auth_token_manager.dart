import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _tokenKey = 'jwt_token';
  static const String _expiryKey = 'jwt_token_expiry';

  final FirebaseAuth _auth;

  TokenManager({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  Future<String?> getToken() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final prefs = await SharedPreferences.getInstance();

    final cachedToken = prefs.getString(_tokenKey);
    final cachedExpiryStr = prefs.getString(_expiryKey);
    final cachedExpiry = cachedExpiryStr != null
        ? DateTime.tryParse(cachedExpiryStr)
        : null;

    final isTokenValid =
        cachedToken != null &&
        cachedExpiry != null &&
        cachedExpiry.isAfter(DateTime.now());

    if (isTokenValid) {
      return cachedToken;
    }

    final result = await user.getIdTokenResult(true);
    final newToken = result.token;
    final expiry = result.expirationTime;

    if (newToken != null && expiry != null) {
      await prefs.setString(_tokenKey, newToken);
      await prefs.setString(_expiryKey, expiry.toIso8601String());
    }

    return newToken;
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_expiryKey);
  }
}
