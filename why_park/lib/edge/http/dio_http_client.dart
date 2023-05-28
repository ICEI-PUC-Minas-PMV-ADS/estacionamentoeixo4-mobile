import 'package:dio/dio.dart';

import 'custom_http_client.dart';
import 'custom_http_response.dart';

class DioHttpClient implements CustomHttpClient {
  DioHttpClient({required final String urlBase}) {
    _dio.options = BaseOptions(
      baseUrl: urlBase,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      responseType: ResponseType.json,
    );
  }

  final Dio _dio = Dio();

  @override
  Duration connectTimeout = const Duration(milliseconds: 15000);

  @override
  Duration receiveTimeout = const Duration(milliseconds: 15000);

  @override
  Duration sendTimeout = const Duration(milliseconds: 15000);

  @override
  Future<CustomHttpResponse> get(
    String path, [
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  ]) async {
    final Response response = await _dio.get(
      path,
      queryParameters: queryParams,
    );
    return _responseToCustomHttpResponse(response);
  }

  @override
  Future<CustomHttpResponse> post(String path,
      [Object? payload,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers]) async {
    final Response response =
        await _dio.post(path, queryParameters: queryParams, data: payload);

    return _responseToCustomHttpResponse(response);
  }

  CustomHttpResponse _responseToCustomHttpResponse(
    final Response response,
  ) =>
      CustomHttpResponse(
        response.data,
        response.statusCode,
        response.statusMessage,
      );
}
