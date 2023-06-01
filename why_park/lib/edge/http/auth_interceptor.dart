import 'package:dio/dio.dart';
import 'package:why_park/edge/session_storage/session_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._sessionStorage);

  final SessionStorage _sessionStorage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer ${_sessionStorage.retrieveSession()}';
    return super.onRequest(options, handler);
  }
}