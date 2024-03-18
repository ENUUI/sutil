import 'package:dio/dio.dart';

/// 错误异常
abstract class IException implements Exception {
  String get display;

  factory IException.from(Object? error) {
    if (error is IException) {
      return error;
    }
    if (error is DioException) {
      return IException._fromDio(error);
    }
    return UnknownException(error: error);
  }

  static IException _fromDio(DioException error) {
    final code = error.response?.statusCode ?? 0;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkException(code, error: error, display: '网络超时');
      case DioExceptionType.badResponse:
        final data = error.response?.data;
        String display;
        if (data is String) {
          display = data;
        } else if (data is Map) {
          display = data.toString();
        } else {
          display = '请求错误';
        }
        return NetworkException(code, error: error, display: display);
      case DioExceptionType.cancel:
        return NetworkException(code, error: error, display: '请求取消');
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return NetworkException(
          code,
          error: error,
          display: '网络错误，请稍后再试',
        );
    }
  }
}

/// 网络异常
class NetworkException implements IException {
  const NetworkException(this.code, {this.display = '网络错误', this.error});

  @override
  final String display;

  final Object? error;

  final int code;

  @override
  String toString() {
    return 'NetworkException{code: $code, display: $display, error: $error}';
  }
}

class UnknownException implements IException {
  const UnknownException({this.display = '未知错误', this.error});

  @override
  final String display;

  final Object? error;

  @override
  String toString() {
    return 'SeeException{display: $display, error: $error}';
  }
}
