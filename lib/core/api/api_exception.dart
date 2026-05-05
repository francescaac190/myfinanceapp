import 'package:dio/dio.dart';

/// Normalized error thrown by every remote data source.
///
/// Backend contract:
///   { "error": { "code": "INVALID_CREDENTIALS", "message": "..." } }
///
/// Falls back to flat `{ "message": "..." }`, plain string body, or a
/// friendly default keyed off Dio's exception type / HTTP status.
class ApiException implements Exception {
  ApiException(this.message, {this.statusCode, this.code});

  factory ApiException.fromDio(DioException e) {
    final status = e.response?.statusCode;
    final parsed = _parseBody(e.response?.data);
    final message = parsed.message ?? _statusFallback(e, status);
    return ApiException(message, statusCode: status, code: parsed.code);
  }

  final String message;
  final int? statusCode;
  final String? code;

  @override
  String toString() => message;

  static _ParsedError _parseBody(dynamic data) {
    if (data is String) {
      final s = data.trim();
      return _ParsedError(message: s.isEmpty ? null : s);
    }
    if (data is! Map) return const _ParsedError();

    final err = data['error'];
    if (err is Map) {
      return _ParsedError(
        message: _readMessage(err['message']),
        code: _readString(err['code']),
      );
    }
    return _ParsedError(
      message: _readMessage(data['message']) ?? _readString(err),
      code: _readString(data['code']),
    );
  }

  static String? _readMessage(dynamic value) {
    if (value is String) return value.trim().isEmpty ? null : value;
    if (value is List && value.isNotEmpty) {
      return value.map((v) => v.toString()).join('\n');
    }
    return null;
  }

  static String? _readString(dynamic value) =>
      value is String && value.isNotEmpty ? value : null;

  static String _statusFallback(DioException e, int? status) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Request timed out. Check your connection and try again.';
      case DioExceptionType.connectionError:
        return 'Cannot reach the server. Check your connection.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.badCertificate:
        return 'Secure connection failed.';
      case DioExceptionType.badResponse:
      case DioExceptionType.unknown:
        break;
    }
    return switch (status) {
      401 => 'Your session expired. Please sign in again.',
      403 => 'You do not have permission to do that.',
      404 => 'The requested resource was not found.',
      final int s when s >= 500 => 'Server error. Please try again later.',
      final int _ => 'Request failed.',
      _ => 'Something went wrong. Please try again.',
    };
  }
}

class _ParsedError {
  const _ParsedError({this.message, this.code});
  final String? message;
  final String? code;
}
