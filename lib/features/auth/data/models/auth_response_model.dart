import 'dart:convert';

import 'package:myfinanceapp/features/auth/data/models/user_model.dart';

class AuthResponseModel {
  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final accessToken = (json['accessToken'] ?? json['access_token']) as String;
    final refreshToken =
        (json['refreshToken'] ?? json['refresh_token']) as String;
    final expiresIn = (json['expiresIn'] ?? json['expires_in']) as int? ??
        _expiresInFromJwt(accessToken) ??
        900;
    final userJson = json['user'] as Map<String, dynamic>?;
    return AuthResponseModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
      user: userJson != null
          ? UserModel.fromJson(userJson)
          : UserModel.fromJwt(accessToken),
    );
  }

  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final UserModel user;

  static int? _expiresInFromJwt(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final claims = jsonDecode(payload) as Map<String, dynamic>;
      final exp = claims['exp'] as int?;
      final iat = claims['iat'] as int?;
      if (exp == null) return null;
      if (iat != null) return exp - iat;
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return exp - now;
    } catch (_) {
      return null;
    }
  }
}
