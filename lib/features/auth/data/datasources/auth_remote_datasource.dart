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

  Future<UserModel> getMe() async {
    if (_mock != null) {
      final json = await _mock.get(ApiEndpoints.usersMe);
      return UserModel.fromJson(json);
    }
    try {
      final response =
          await _dio.get<Map<String, dynamic>>(ApiEndpoints.usersMe);
      return UserModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<void> logout(String refreshToken) async {
    if (_mock != null) {
      return;
    }
    try {
      await _dio.post<dynamic>(
        ApiEndpoints.authLogout,
        data: {'refreshToken': refreshToken},
      );
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<void> logoutAll() async {
    if (_mock != null) {
      return;
    }
    try {
      await _dio.post<dynamic>(ApiEndpoints.authLogoutAll);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<AuthResponseModel> _post(
      String path, Map<String, dynamic> body) async {
    if (_mock != null) {
      log('POST $path with body: $body');
      final json = await _mock.post(path, body);
      return AuthResponseModel.fromJson(json);
    }
    try {
      final r = await _dio.post<Map<String, dynamic>>(path, data: body);
      return AuthResponseModel.fromJson(r.data!);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  ApiException _toApiException(DioException e) {
    final code = e.response?.statusCode;
    final raw = e.response?.data is Map
        ? (e.response!.data['message'] ?? e.message)
        : e.message;
    return ApiException(raw?.toString() ?? 'Network error', statusCode: code);
  }
}
