import 'package:dio/dio.dart';
import 'package:myfinanceapp/core/api/api_exception.dart';

class ApiErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error is ApiException) {
      return handler.next(err);
    }
    final wrapped = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: ApiException.fromDio(err),
      stackTrace: err.stackTrace,
      message: err.message,
    );
    handler.next(wrapped);
  }
}
