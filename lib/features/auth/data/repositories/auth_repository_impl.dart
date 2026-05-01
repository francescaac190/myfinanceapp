import 'package:myfinanceapp/core/api/api_exception.dart';
import 'package:myfinanceapp/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:myfinanceapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:myfinanceapp/features/auth/domain/entities/auth_tokens.dart';
import 'package:myfinanceapp/features/auth/domain/entities/user.dart';
import 'package:myfinanceapp/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._local);

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  @override
  Future<User> login(String email, String password) async {
    final r = await _remote.login(email, password);
    await _local.saveTokens(
      accessToken: r.accessToken,
      refreshToken: r.refreshToken,
      expiresInSeconds: r.expiresIn,
    );
    return r.user;
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final r = await _remote.register({
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    });
    await _local.saveTokens(
      accessToken: r.accessToken,
      refreshToken: r.refreshToken,
      expiresInSeconds: r.expiresIn,
    );
    return r.user;
  }

  @override
  Future<void> logout() async {
    final refreshToken = await _local.getRefreshToken();
    if (refreshToken != null) {
      try {
        await _remote.logout(refreshToken);
      } on ApiException {
        // network/server error — still clear local tokens
      }
    }
    await _local.clearTokens();
  }

  @override
  Future<void> logoutAll() async {
    try {
      await _remote.logoutAll();
    } on ApiException {
      // server error — still clear local tokens
    }
    await _local.clearTokens();
  }

  @override
  Future<User> getCurrentUser() => _remote.getMe();

  @override
  Future<AuthTokens?> currentTokens() async {
    final access = await _local.getAccessToken();
    final refresh = await _local.getRefreshToken();
    final expiresAt = await _local.getAccessTokenExpiry();
    if (access == null || refresh == null || expiresAt == null) {
      return null;
    }
    return AuthTokens(
      accessToken: access,
      refreshToken: refresh,
      expiresAt: expiresAt,
    );
  }

  @override
  Future<User?> bootstrap() async {
    final tokens = await currentTokens();
    if (tokens == null) {
      return null;
    }
    try {
      return await _remote.getMe();
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        await _local.clearTokens();
        return null;
      }
      rethrow;
    }
  }
}
