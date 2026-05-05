import 'package:dio/dio.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/auth/data/datasources/auth_local_datasource.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(this._local, this._dio, {this.onSessionExpired});
  final Dio _dio;
  final AuthLocalDataSource _local;
  final void Function()? onSessionExpired;

  static const _skipAuth = {
    ApiEndpoints.authLogin,
    ApiEndpoints.authRegister,
    ApiEndpoints.authRefresh,
    ApiEndpoints.authLogout,
  };

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_skipAuth.contains(options.path)) {
      return handler.next(options);
    }
    final token = await _local.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final isAuthCall = _skipAuth.contains(err.requestOptions.path);
    if (err.response?.statusCode != 401 || isAuthCall) {
      return handler.next(err);
    }
    final newToken = await _refreshTokens();
    if (newToken == null) {
      return handler.next(err);
    }
    final req = err.requestOptions;
    req.headers['Authorization'] = 'Bearer $newToken';
    try {
      final retry = await _dio.fetch<dynamic>(req);
      return handler.resolve(retry);
    } catch (e) {
      return handler.next(err);
    }
  }

  Future<String?> _refreshTokens() async {
    final refreshToken = await _local.getRefreshToken();
    if (refreshToken == null) {
      await _local.clearTokens();
      onSessionExpired?.call();
      return null;
    }
    try {
      final r = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.authRefresh,
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Authorization': null}),
      );
      final data = r.data!;
      final access = data['accessToken'] as String;
      await _local.saveTokens(
        accessToken: access,
        refreshToken: data['refreshToken'] as String,
        expiresInSeconds: data['expiresIn'] as int,
      );
      return access;
    } catch (_) {
      await _local.clearTokens();
      onSessionExpired?.call();
      return null;
    }
  }
}
