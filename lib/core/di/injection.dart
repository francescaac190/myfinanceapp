import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:myfinanceapp/core/api/auth_interceptor.dart';
import 'package:myfinanceapp/core/api/mock_api_service.dart';
import 'package:myfinanceapp/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:myfinanceapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:myfinanceapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:myfinanceapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:myfinanceapp/features/auth/presentation/bloc/auth_bloc.dart';

const _useMock = bool.fromEnvironment('USE_MOCK');

final getIt = GetIt.instance;
Future<void> setupDependencies() async {
  getIt
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      ),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(getIt()),
    )
    ..registerLazySingleton<MockApiService>(MockApiService.new)
    ..registerLazySingleton<Dio>(() {
      final dio = Dio(BaseOptions(
        baseUrl: const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'http://localhost:4000/api/v1',
        ),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ));
      dio.interceptors.add(AuthInterceptor(getIt(), dio));
      if (kDebugMode) {
        dio.interceptors.add(
          LogInterceptor(
            requestBody: true,
            responseBody: true,
            logPrint: (obj) => debugPrint(obj.toString()),
          ),
        );
      }
      return dio;
    })
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        getIt(),
        mock: _useMock ? getIt<MockApiService>() : null,
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(getIt())..add(AuthBootstrapRequested()),
    );
}
