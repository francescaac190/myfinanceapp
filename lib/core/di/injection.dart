import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:myfinanceapp/core/api/api_error_interceptor.dart';
import 'package:myfinanceapp/core/api/auth_interceptor.dart';
import 'package:myfinanceapp/core/api/mock_api_service.dart';
import 'package:myfinanceapp/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:myfinanceapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:myfinanceapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:myfinanceapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:myfinanceapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myfinanceapp/features/bills/data/datasources/bills_remote_datasource.dart';
import 'package:myfinanceapp/features/bills/data/repositories/bills_repository_impl.dart';
import 'package:myfinanceapp/features/bills/domain/repositories/bills_repository.dart';
import 'package:myfinanceapp/features/bills/presentation/bloc/bills_bloc.dart';
import 'package:myfinanceapp/features/home/data/datasources/home_overview_remote_datasource.dart';
import 'package:myfinanceapp/features/home/data/repositories/home_overview_repository_impl.dart';
import 'package:myfinanceapp/features/home/domain/repositories/home_overview_repository.dart';
import 'package:myfinanceapp/features/home/presentation/bloc/home_overview_bloc.dart';

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
      dio.interceptors.add(
        AuthInterceptor(
          getIt(),
          dio,
          onSessionExpired: () =>
              getIt<AuthBloc>().add(AuthSessionExpired()),
        ),
      );
      dio.interceptors.add(ApiErrorInterceptor());
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
      () => AuthBloc(getIt()),
    )
    ..registerLazySingleton(
      () => HomeOverviewRemoteDataSource(getIt<Dio>()),
    )
    ..registerLazySingleton<HomeOverviewRepository>(
      () => HomeOverviewRepositoryImpl(getIt()),
    )
    ..registerFactory(() => HomeOverviewBloc(getIt()))
    ..registerLazySingleton(
      () => BillsRemoteDataSource(getIt<Dio>()),
    )
    ..registerLazySingleton<BillsRepository>(
      () => BillsRepositoryImpl(getIt()),
    )
    ..registerFactory(() => BillsBloc(getIt()));
}
