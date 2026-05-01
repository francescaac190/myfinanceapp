import 'dart:convert';

import 'package:myfinanceapp/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.avatarUrl,
    super.isEmailVerified,
    super.isPro,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      firstName: (json['firstName'] ?? json['first_name'] ?? '') as String,
      lastName: (json['lastName'] ?? json['last_name'] ?? '') as String,
      avatarUrl: (json['avatarUrl'] ?? json['avatar_url']) as String?,
      isEmailVerified: json['emailVerifiedAt'] != null ||
          json['email_verified_at'] != null ||
          (json['isEmailVerified'] as bool? ?? false),
      isPro: (json['isPro'] ?? json['is_pro'] ?? false) as bool,
    );
  }

  factory UserModel.fromJwt(String token) {
    final claims = _decodeJwtPayload(token);
    return UserModel(
      id: (claims['sub'] ?? '') as String,
      email: (claims['email'] ?? '') as String,
      firstName: (claims['firstName'] ?? '') as String,
      lastName: (claims['lastName'] ?? '') as String,
      isPro: (claims['isPro'] as bool?) ?? false,
    );
  }

  static Map<String, dynamic> _decodeJwtPayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return const {};
      final payload =
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      return jsonDecode(payload) as Map<String, dynamic>;
    } catch (_) {
      return const {};
    }
  }
}
