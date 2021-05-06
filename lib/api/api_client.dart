import 'package:dio/dio.dart';

import 'error/error_interceptor.dart';

class ApiClient {
  static Interceptor? observer;
  static Interceptor errorObserver = ErrorInterceptor();

  ApiClient._();

  static Dio create(String baseUrl) {
    final options = BaseOptions(baseUrl: baseUrl);
    final client = Dio(options);

    client.interceptors.add(errorObserver);

    if (observer != null) {
      client.interceptors.add(observer!);
    }

    return client;
  }
}
