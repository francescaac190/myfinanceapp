import 'package:dio/dio.dart';
import 'package:myfinanceapp/core/api/api_exception.dart';

/// Wraps any Dio call so callers always see [ApiException] (never DioException).
/// Use for every remote data source method:
///
///   Future<Foo> getFoo() => apiCall(() async {
///     final r = await _dio.get<Map<String, dynamic>>('/foo');
///     return Foo.fromJson(r.data!);
///   });
Future<T> apiCall<T>(Future<T> Function() run) async {
  try {
    return await run();
  } on ApiException {
    rethrow;
  } on DioException catch (e) {
    if (e.error is ApiException) {
      throw e.error! as ApiException;
    }
    throw ApiException.fromDio(e);
  }
}
