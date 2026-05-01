import 'package:dio/dio.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/auth/data/datasources/auth_local_datasource.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(this._local, this._dio);
  final Dio _dio;
  final AuthLocalDataSource _local;

  static const _skipAuth = {
    ApiEndpoints.authLogin,
    ApiEndpoints.authRegister,
    ApiEndpoints.authRefresh,
    ApiEndpoints.authLogout,
  };

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!_skipAuth.contains(options.path)) {
      final token = await _local.getAccessToken();

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
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
    final refreshToken = await _local.getRefreshToken();
    if (refreshToken == null) {
      await _local.clearTokens();
      return handler.next(err);
    }
    try {
      final r = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.authRefresh,
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Authorization': null}),
      );
      final data = r.data!;
      await _local.saveTokens(
        accessToken: data['accessToken'] as String,
        refreshToken: data['refreshToken'] as String,
        expiresInSeconds: data['expiresIn'] as int,
      );
      // retry original
      final req = err.requestOptions;
      req.headers['Authorization'] = 'Bearer ${data['accessToken']}';
      final retry = await _dio.fetch<dynamic>(req);
      return handler.resolve(retry);
    } catch (_) {
      await _local.clearTokens();
      return handler.next(err);
    }
  }
}
