import 'custom_http_response.dart';

abstract class CustomHttpClient {
  abstract Duration receiveTimeout;
  abstract Duration connectTimeout;
  abstract Duration sendTimeout;

  Future<CustomHttpResponse> get(
    final String path, [
    final Map<String, dynamic> queryParams,
    final Map<String, dynamic> headers,
  ]);

  Future<CustomHttpResponse> post(
      final String path, [
        final Object payload,
        final Map<String, dynamic> queryParams,
        final Map<String, dynamic> headers,
      ]);

  Future<CustomHttpResponse> delete(
      final String path, [
        final Map<String, dynamic> queryParams,
        final Map<String, dynamic> headers,
      ]);

  Future<CustomHttpResponse> patch(
      final String path, [
        final Object payload,
        final Map<String, dynamic> queryParams,
        final Map<String, dynamic> headers,
      ]);
}
