import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/auth/data/models/auth_response_model.dart';
import 'package:myfinanceapp/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio, {MockApiService? mock}) : _mock = mock;
  final Dio _dio;
  final MockApiService? _mock;

  Future<AuthResponseModel> login(String email, String password) =>
      _post(ApiEndpoints.authLogin, {'email': email, 'password': password});

  Future<AuthResponseModel> register(Map<String, dynamic> body) =>
      _post(ApiEndpoints.authRegister, body);

  Future<AuthResponseModel> refresh(String refreshToken) =>
      _post(ApiEndpoints.authRefresh, {'refreshToken': refreshToken});

  Future<UserModel> getMe() => apiCall(() async {
        if (_mock != null) {
          final json = await _mock.get(ApiEndpoints.usersMe);
          return UserModel.fromJson(json);
        }
        final response =
            await _dio.get<Map<String, dynamic>>(ApiEndpoints.usersMe);
        return UserModel.fromJson(response.data!);
      });

  Future<void> logout(String refreshToken) => apiCall(() async {
        if (_mock != null) return;
        await _dio.post<dynamic>(
          ApiEndpoints.authLogout,
          data: {'refreshToken': refreshToken},
        );
      });

  Future<void> logoutAll() => apiCall(() async {
        if (_mock != null) return;
        await _dio.post<dynamic>(ApiEndpoints.authLogoutAll);
      });

  Future<AuthResponseModel> _post(String path, Map<String, dynamic> body) =>
      apiCall(() async {
        if (_mock != null) {
          log('POST $path with body: $body');
          final json = await _mock.post(path, body);
          return AuthResponseModel.fromJson(json);
        }
        final r = await _dio.post<Map<String, dynamic>>(path, data: body);
        return AuthResponseModel.fromJson(r.data!);
      });
}
